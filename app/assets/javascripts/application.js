// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require_tree .

function showBrand(window_width) {
  if (window_width >= 980) {
    $("#brandid").hide();
  } else {
    $("#brandid").show();
  }
};

$(window).resize(function() {
  showBrand($(window).width());
})

$(function() {
  showBrand($(window).width());
});

WebFontConfig = {
  google: {
    families: ['Satisfy']
  },
  monotype: {
    projectId: '1add1a27-fd5a-4a23-82f9-eaf3b73d689a',
    version: 12345 // (optional, flushes the CDN cache)
  },
  timeout: 2000 // Set the timeout to two seconds
};