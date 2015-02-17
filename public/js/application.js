"use strict";

// サーバからログを取得して表示
$(function() {
  $("#searcher").submit(function(e) {
    e.preventDefault();
    hideAllAlert();
    $("#result-body").empty();
    disableSubmitButton();
    showInfoAlert();

    var $target = $(e.target);
    $.ajax({
      url:  $target.attr('action'),
      type: $target.attr('method'),
      data: $target.serialize()
    }).done(function(data) {
      var logs = $.map(data["logs"], function(log) {
        log["other"] = JSON.stringify(log["other"] || {}, null, 2);
        return log;
      });

      $('#tmpl_info').tmpl(logs).appendTo('#result-body');
      removeDisabledFromSubmitButton();
      hideAllAlert();
    }).fail(function(jqXHR, status) {
      showDangerAlert();
      removeDisabledFromSubmitButton();
      hideInfoAlert();
    });

    return false;
  });

  function disableSubmitButton(){
    $("#searcher-submit-btn").prop("disabled", true);
  }

  function removeDisabledFromSubmitButton(){
    $("#searcher-submit-btn").prop("disabled", false);
  }

  function hideAllAlert() {
    $(".alert").hide();
  }

  function hideInfoAlert() {
    $("#info-alert").hide();
  }

  function showInfoAlert() {
    var message = "検索中です。";
    $("#info_message").html(message);
    $("#info-alert").show();
  }
  function showDangerAlert() {
    var message = "エラーが起きました。少し時間をあけて再度実行してください";
    $("#error_message").html(message);
    $("#danger-alert").show();
  }
});

// その他を見せたり隠したりする
$(function() {
  $("#result-body").on('click', ".other-toggle", function(e) {
    e.preventDefault();

    var $target = $(e.target);
    var id = $target.data('id');
    var $dialog = $("#other-" + id + "-dialog");

    toggleLink(id, $dialog.is(':hidden'));
    toggleIcon(id, $dialog.is(':hidden'));

    $dialog.toggle();
  });

  function toggleLink(id, currentIsHidden) {
    var $target = $("#other-" + id + "-link");
    var linkName = "見る";
    if (currentIsHidden) {
      linkName = "隠す";
    }
    $target.html(linkName);
  }

  function toggleIcon(id, currentIsHidden) {
    var $target = $("#other-" + id + "-icon");

    var hideIcon = "glyphicon-remove-circle";
    var showIcon = "glyphicon-check";

    var removeClass = hideIcon;
    var addClass    = showIcon;
    if (currentIsHidden) {
      removeClass = showIcon;
      addClass    = hideIcon;
    }
    $target.removeClass(removeClass);
    $target.addClass(addClass);
  }
});

// 「次へ」「前へ」を実装
$(function() {
  $(".next").click(function(e) {
    e.preventDefault();

    var $page = $("#page");
    var pageCount = $page.val() || 1;
    var nextPage = parseInt(pageCount, 10) + 1;

    $page.val(nextPage);
    $("#searcher").submit();
  });

  $(".previous").click(function(e) {
    e.preventDefault();

    var $page = $("#page");
    var pageCount = $page.val() || 1;
    var nextPage = parseInt(pageCount, 10) - 1;
    if (nextPage <= 0) {
      return;
    }

    $page.val(nextPage);
    $("#searcher").submit();
  });
});
