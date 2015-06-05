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
    $("#query").removeClass("span5").addClass("span3");
  } else {
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
var renderer = new marked.Renderer();

renderer.image = function (href, title, text) {
  var out = '<img class= "imgcenter" src="' + href + '" alt="' + text + '"';
  if (title) {
    out += ' title="' + title + '"';
  }
  out += this.options.xhtml ? '/>' : '>';
  return out;
}

renderer.footnoteref = function (key, count) {
  var out = '<span class="footnote-ref" id="fnref' + escape(key) + '"></span>' + '<sup>';
  out += '<a href="#fn' + escape(key) + '">' + count + '</a></sup>';
  return out;
}

marked.setOptions({
  footnotes: true,
  breaks: true
})


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
  if (window.location.origin == window.location.href.replace(/\/$/,'')) {
    $( ".alert" ).remove();
    $( "div.top" ).removeClass('container top');
    screen_width = $( window ).width()
    screen_height = $( window ).height()
    width = screen_width * 0.17254313578394598
    height = screen_height * 0.26136363636363635
    wh = (width >= height)? width:height
    $('div.centered').height(wh)
    $('div.centered').width(wh)
    $('div.main').css({"display":"block"})
  }
})
$(window).load(function() {
  screen_width = $( window ).width()
  screen_height = $( window ).height()
  if(window.location.origin == window.location.href.replace(/\/$/,'')) {
    function setVolume(){
      if(typeof(Storage) !== "undefined") {
        if(localStorage.volumeState !== undefined){
          if(localStorage.volumeState == "0"){
            document.getElementById('player').muted = true
            $( ".volume_button" ).children().toggleClass( "icon-volume-up icon-volume-off" )
          }
        }else{
          localStorage.setItem("volumeState", '1');
        }
      }
    }
    setVolume()
    function setVolumeState(){
      if(typeof(Storage) !== "undefined") {
        if($( ".volume_button" ).children().hasClass('icon-volume-up')){
          localStorage.setItem("volumeState", '1')
        }else{
          localStorage.setItem("volumeState", '0')
        }
      }
    }
    $( "div#recent-posts li" ).first().addClass('active')
    $('#recent-posts-tab a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    })
    $( ".volume_button" ).click(function() {
      document.getElementById('player').muted=!document.getElementById('player').muted
      $( this ).children().toggleClass( "icon-volume-up icon-volume-off" )
      setVolumeState()
    });
    div_id = 'selections'
    $( ".down_arrow" ).click(function() {
      if ($('.icon-double-angle-down').is(':visible')) {
        $('html, body').animate({scrollTop: $("#"+div_id).offset().top}, 'slow');
        if (div_id == 'selections') {
          div_id = 'recent-posts'
        } else if(div_id == 'recent-posts'){
          div_id = 'selections'
          $( this ).children().toggle()
        }
      }else{
        $('html, body').animate({scrollTop: 0}, 'slow');
        $( this ).children().toggle()
      };
    });
    $('div.main').css('border-bottom', '2px dotted gainsboro')
    $('div#selections').css({"display":"table"});
    $('button.volume_button').css("display","block");
    $('#selections').css("height", (screen_height) + "px");
    $('#myCarousel').css({"display":"table-cell"});
    $('#myCarousel').css({"vertical-align":"middle"});
    $('#recent-posts').css({"display":"table"});
    $('#recent-posts').css("height", (screen_height) + "px");
    $('.tab-page').css({"display":"table-cell"});
    $('.tab-page').css({"vertical-align":"middle"});
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
    function dimensionOfImage(){
      size = Math.floor(Math.random() * 8) + 3
      width = height = Math.floor(screen_width * size / 100)
      return [width,height]
    }
    dimensions = dimensionOfImage()
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
      img.appendTo('.symboldiv')
    }
    drawImage();
    function intersectRect(r1, r2) {
      return !((r2.left - 20) > r1.right ||
        (r2.right + 20) < r1.left ||
        (r2.top - 20) > r1.bottom ||
        (r2.bottom + 20) < r1.top);
    }
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
  };
});

function month_wise_post_count(year) {

  var callback = createSubTree;
  if($('#'+year).text() == ""){
    $('#loading-image').show();
    $.ajax({
        url: '/blogs/'+window.blog_url+'/archives/'+year,
        dataType: "jsonp",
        complete: function(data) {
          callback(data,year);
          $('#loading-image').hide();
        }
      });
  }

  function createSubTree(data,year){
    var months = {
    '1' : 'January',
    '2' : 'February',
    '3' : 'March',
    '4' : 'April',
    '5' : 'May',
    '6' : 'Jun',
    '7' : 'July',
    '8' : 'August',
    '9' : 'September',
    '10' : 'October',
    '11' : 'November',
    '12' : 'December',
    }
    $.each($.parseJSON(data.responseText), function(key, value) {
      key = Math.round( key );
      var li = "<li class='subfolder'><label for='f"+year+key+"' onclick='months_posts("+year+","+key+");'><span class='ltag'>"+months[key]+" ("+value+")</span></label><input class='textin' type='checkbox' id='f"+year+key+"'><ol id='l"+year+key+"'></ol></li>";
      var new_item = $(li).hide();
      $('#'+year).append(new_item);
      new_item.show('normal');
    });
  }
}
function months_posts(year,month){
  var callback = createSubTreeLinks;
  if($('#l'+year+month).text() == ""){
    $('#loading-image').show();
    $.ajax({
        url: '/blogs/'+window.blog_url+'/archives/'+year+'/'+month,
        dataType: "jsonp",
        complete: function(data) {
          callback(data,year,month);
            $('#loading-image').hide();
        }
      });
  }
  function createSubTreeLinks(data,year,month){
    $.each($.parseJSON(data.responseText), function(key, value) {
      var li = "<li class='file sidebar-links'><a href='posts/"+value.url+"'>"+value.title+"</a></li>";
      var new_item = $(li).hide();
      $('#l'+year+month).append(new_item);
      new_item.show('normal');
    });
  }
}

$(document).ready(function(){
  if ( window.location.pathname == '/read/1/1/1' && (window.location.search == '' || window.location.search == '?edition=1950')) {
    $.ajax({
      url: '/sections/'+$('.reference')[0].id.match(/\d+/)[0]+'/commentaries.json',
      dataType: 'jsonp',
      complete: function(data){
        $.each($.parseJSON(data.responseText), function(key, value) {
          if(value.data){
          $.each(value.data, function(k, v) {
            if(k == 'mother' && v!= ''){
              v = marked(v, { renderer: renderer })
              str = ''
              $(v).removeAttr('id').each(function(i, j) {
                if (j.outerHTML !== undefined) str += j.outerHTML
              })
              $('<span class="pull-right" id="m'+ value.data.start_stanza +'">\
                <i class="icon-circle" data-html=true data-placement="left"\
                data-start='+ value.data.start_stanza +' data-end='+
                value.data.end_stanza +' data-original-title="The Mother"\
                data-content="'+ str +'"></i>&nbsp;&nbsp;&nbsp;&nbsp;<span> ')
              .insertAfter('#p'+value.data.start_stanza +' .reference a')
            }else if(k == 'aurobindo' && v!= ''){
              v = marked(v, { renderer: renderer })
              str = ''
              $(v).removeAttr('id').each(function(i, j) {
                if (j.outerHTML !== undefined) str += j.outerHTML
              })
              $('<span class="pull-right" id="m'+ value.data.start_stanza +'"><i class="icon-star" data-html=true data-placement="left" data-start='+ value.data.start_stanza +' data-end='+ value.data.end_stanza +' data-original-title="Sri Aurobindo" data-content="' + str + '"</i>&nbsp;&nbsp;&nbsp;&nbsp;<span> ').insertAfter('#p'+value.data.start_stanza +' .reference a')
            }
          });
          }
          $('.icon-circle').css('color','white');
        });
      }
    })
  }
})

$(document).on('mouseover',".icon-circle, .icon-star",  function(){
  for (var i = $(this).data('start'); i <= $(this).data('end'); i++) {
    $('#p'+i).addClass("hover_me");
  };
  $(this).popover('show',$(this).id)
})
$(document).on('mouseout',".icon-circle, .icon-star",  function(){
  for (var i = $(this).data('start'); i <= $(this).data('end'); i++) {
    $('#p'+i).removeClass("hover_me");
  };
  $(this).popover('hide',$(this).id)
})
