"use strict";

// サーバからログを取得して表示
$(function() {
  $("#searcher").submit(function(e) {
    e.preventDefault();
    $("#result-body").empty();

    var $target = $(e.target);
    $.ajax({
      url:  $target.attr('action'),
      type: $target.attr('method'),
      data: $target.serialize()
    }).done(function(data) {
        console.log(data);
      $('#tmpl_info').tmpl(data["logs"]).appendTo('#result-body');
    }).fail(function(jqXHR, status) {
    });

    return false;
  });
});

// その他を見せたり隠したりする
$(function() {
  $("#result-body").on('click', ".other-toggle", function(e) {
    e.preventDefault();

    var $target = $(e.target);
    var id = $target.data('id');
    var $dialog = $("#other-" + id + "-dialog");

    toggleLink(id, $dialog.is(':hidden'));

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
