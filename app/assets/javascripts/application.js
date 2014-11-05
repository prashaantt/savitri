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

converter = new Markdown.Converter();


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
$(document).ready(function(){
  screen_width = $( window ).width()
  screen_height = $( window ).height()
  width = screen_width * 0.17254313578394598
  height = screen_height * 0.26136363636363635
  wh = (width >= height)? width:height
  $('div.centered').height(wh)
  $('div.centered').width(wh)
})
$(window).load(function() {
  screen_width = $( window ).width()
  screen_height = $( window ).height()
  if (window.location.origin == window.location.href.replace(/\/$/,'')) {
    $( ".alert" ).remove();
    $( "div.top" ).removeClass('container top');
    $( "body" ).css('background-color','#C4AF96');
    $( ".volume_button" ).click(function() {
      document.getElementById('player').muted=!document.getElementById('player').muted
      $( this ).children().toggleClass( "icon-volume-up icon-volume-off" )
    });
    $( ".down_arrow" ).click(function() {
      if ($('.icon-double-angle-down').is(':visible')) {
        $('html, body').animate({scrollTop: screen_height}, 'slow');
      } else{
        $('html, body').animate({scrollTop: 0}, 'slow');
      };
       $( this ).children().toggle()
    });
  };
  $('div.symboldiv').css({'min-height': screen_height})
  mother_symbol_images = []
  aurobindo_symbol = $('div.centered img')[0]
  centeredImagePostion = {
                           left:(screen_width/2) - (aurobindo_symbol.width/2), //aurobindo_symbol.offsetLeft,
                           top:(screen_height/2) - (aurobindo_symbol.height/2),//aurobindo_symbol.offsetTop,
                           right:(screen_width/2) + (aurobindo_symbol.width/2),//aurobindo_symbol.offsetLeft + 358,
                           bottom:(screen_height/2) + (aurobindo_symbol.height/2) //aurobindo_symbol.offsetTop + 333,
                         }
  h = -2
  function getNewPosition(){
    x = Math.floor(Math.random () * (screen_width - (aurobindo_symbol.width/2)))
    if (h==-2) {
      h = 2
    } else{
      h = -2
    };
    y = Math.floor(Math.random () * (screen_height*h - (aurobindo_symbol.height/2)))
    return [x,y]
  }
  newPosition = [0,0]
  dimensions = dimensionOfImage()
  function dimensionOfImage(){
    size = Math.floor(Math.random() * 8) + 3
    width = height = Math.floor(screen_width * size / 100)
    return [width,height]
  }
  drawImage();
  // $('.carousel').carousel({
  //   interval: 5000
  // })
  mother_symbol_images.push({
                              left:newPosition[0],
                              top:newPosition[1],
                              right:newPosition[0] + dimensions[0],
                              bottom:newPosition[1]+dimensions[1]
                            })
  function drawImage(){
    var img = $('<img class="mother_symbol">');
    img.attr('src', 'assets/Mother\'s Symbol Large.png');
    img.css({
      "left": (newPosition[0]) + "px",
      "top": (newPosition[1]) + "px",
      "width": (dimensions[0]) + "px",
      "height": (dimensions[1]) + "px",
      "display": "none",
      "position": "absolute"
    });
    // img.css('opacity', 1)
    img.appendTo('.symboldiv')
  }
    $('div.main').css('border-bottom', '2px dotted gainsboro')
    $('.container').css({"display":"block"});
    $('button.volume_button').css("display","block");
    $('#selections').css("height", (screen_height) + "px");
    $('#myCarousel').css("margin-top", "25%");
    for (var i = 1; i <= 2000; i++) {
      newPosition = getNewPosition()
      dimensions = dimensionOfImage()
      newImagePostion = {
                          left:newPosition[0], 
                          top:newPosition[1],
                          right:(newPosition[0] + dimensions[0]),
                          bottom:(newPosition[1] + dimensions[1])
                        }
      total_symbols = mother_symbol_images.length
      count = 0
      $.each(mother_symbol_images, function( index, value ) {
        if(intersectRect(value,newImagePostion)){
          return false
        }
        else{
          count += 1
         }
        if(total_symbols == count){
          if(intersectRect(centeredImagePostion,newImagePostion)) {
          }
          else{
            drawImage()
            mother_symbol_images.push(newImagePostion)
          };
          return false
          }
      });
      if($('img').length == 250 || i == 2000){
        mother_symbols = $('img.mother_symbol').fadeIn(5000)
        return false;
      }
    };
    function intersectRect(r1, r2) {
      return !((r2.left - 20) > r1.right || 
      (r2.right + 20) < r1.left || 
      (r2.top - 20) > r1.bottom ||
      (r2.bottom + 20) < r1.top);
    }
});
