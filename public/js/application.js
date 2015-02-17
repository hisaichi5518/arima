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
