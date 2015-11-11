
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap
$(function() {
   
    $("#cds_search input").keyup(function() {
    $.get($("#cds_search").attr("action"), $("#cds_search").serialize(), null, "script");
    return false;
  });
}); 


