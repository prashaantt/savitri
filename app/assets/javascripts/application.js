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
//= require jquery.purr
//= require best_in_place
//= require_tree .

function showBrand(window_width) {
  if (window_width >= 965) {
    $("#brandid").hide();
    $("#query").removeClass("span5").addClass("span3");
  } else {
    $("#brandid").show();
    $("#query").removeClass("span3").addClass("span5");
  }
};

/*function isScrollBarVisible() {
  return (this.get(0))?this.get(0).scrollHeight>this.innerHeight():false;
}*/

$(window).resize(function() {
  showBrand($(window).width());
})

$(function() {
  showBrand($(window).width());
  setSpan($(window).width());
});

$(function() {
  $('#query').on('propertychange keyup keydown input paste focus', function() {
    $(this).val().length ? $("#removeicon").css("display","inline") :  $("#removeicon").css("display","none");
  });
  $("#removeicon").on('click', function() {
    $('input[name=q]').val('');
    $("#removeicon").css("display","none");
  });
});

$(function(){
  $('#search-submit').click(function(e){
    var loc = $('input[name=q]').val().trim();
      if (loc.search(/\d+\.\d+$/)!=-1)
      {
        document.location.href="/read/"+loc;
        return false;
      }
  });
  $('input[name=q]').keypress(function(e) {
    if(e.which == 13) {
      var loc = $('input[name=q]').val().trim();
      if (loc.search(/\d+\.\d+$/)!=-1)
      {
        document.location.href="/read/"+loc;
        return false;
      }
    }
  });
});


setSpan = function(window_width) {
  if (window_width >= 1200) {
    $("#read").removeClass().addClass("span6").addClass("offset1");
    $(".dynamicspan").removeClass('dynamicspan span10 span6').addClass("dynamicspan span9");
    $(".dynaudiospan").removeClass().addClass("dynaudiospan span6");
  } else if (window_width >= 965 && window_width < 1200) {
    $("#read").removeClass().addClass("span6").addClass("offset3");
    $(".dynamicspan").removeClass('dynamicspan span10 span6').addClass("dynamicspan span9");
    $(".dynaudiospan").removeClass().addClass("dynaudiospan span6");
  } else if (window_width > 752 && window_width < 965) {
    $("#read").removeClass().addClass("span10").addClass("offset1");
    $(".dynamicspan").removeClass('dynamicspan span10 span6').addClass("dynamicspan span9 offset1");
    $(".dynaudiospan").removeClass().addClass("dynaudiospan span10");
  } else {
    $("#read").removeClass().addClass("span6");
    $(".dynamicspan").removeClass('dynamicspan span10 span6').addClass("dynamicspan span9");
    $(".dynaudiospan").removeClass().addClass("dynaudiospan span6");
  }

  /*if (window_width >= 753) {
    $("#text").css("padding-left", "3%");
  } else {
    $("#text").css("padding", "0");
  }*/

  if (window_width >= 1185) {
    $(".dynahomespan").removeClass("span12").addClass("span9");
  } else if (window_width >= 965 && window_width < 1185) {
    $(".dynahomespan").removeClass("span9").addClass("span12");
  } else if (window_width > 752 && window_width < 965) {
    $(".dynahomespan").removeClass("span9").addClass("span12");
  } else {
    $(".dynahomespan").removeClass("span9").addClass("span12");
  }
  
  if (window_width > 611 && window_width < 768) {
    return $("#read").addClass("read-margins");
  } else {
    return $("#read").removeClass("read-margins");
  }
};

$(window).resize(function() {
  return setSpan($(window).width());
});


/*WebFontConfig = {
  google: {
    families: ['Satisfy']
  },
  monotype: {
    projectId: '1add1a27-fd5a-4a23-82f9-eaf3b73d689a',
    version: 12345 // (optional, flushes the CDN cache)
  },
  timeout: 2000 // Set the timeout to two seconds
};
*/