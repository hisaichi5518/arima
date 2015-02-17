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
