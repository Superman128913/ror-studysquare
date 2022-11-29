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
//= require_tree .

$(function() {
  $('#popover, a[rel=popover]').popover({
    placement: 'top',
    animation: true,
    trigger: 'hover',
  });

  $('.mobile-toggle').click(function() {
    $('.mobile-nav').toggleClass("expanded");
    $('.mobile-navbar').toggleClass("expanded-right");
  });

  // Mobile
  if (window.innerWidth < 960)
    $('a').click(function (event) {
      var href = $(this).attr("href")

      if (!href)
        return;

      event.preventDefault();
      window.location = href;
    });

  $(".left-menu").hover(
    function () {
      $(this).addClass('leftmenu-hover');
    }, 
    function () {
      $(this).removeClass('leftmenu-hover');
    }
  )

  $(".right-menu").hover(
    function () {
      $(this).addClass('rightmenu-hover');
    }, 
    function () {
      $(this).removeClass('rightmenu-hover');
    }
  )
  
  $(".cart-order").click(
    function () {
      $('.right-menu').addClass('rightmenu-hover');
    }
  )
  
  $(".subnavmenu li").hover(
    function () {
      $(this).addClass('open');
    }, 
    function () {
      $(this).removeClass('open');
    }
  )

  // Chosen
  $('#course_program_course_id, #course_tutor_id').chosen()

  // Registrations manager
  if ($('#manager-registrations').length > 0)
    setInterval(function() {
      $.get('/manager/registrations', function(data) {
        $('.main-container').html(data);
      })
    }, 10000);
    
  
  $(".btn_contact").click(function(e) {
    var count = 0; 
    $('.controls .required').css('border', 'solid 1px rgb(204, 204, 204)');
    if($('#contact_name').val()){
      count++;
    }else{
      $('#contact_name').css('border', 'solid 1px red');
    }
    if($('#contact_email').val()){
      count++;
    }else{
      $('#contact_email').css('border', 'solid 1px red');
    }
    if(validateEmail($('#contact_email').val())){
      count++;
    }else{
      $('#contact_email').css('border', 'solid 1px red');
    }
    if($('#contact_telephone').val()){
      count++;
    }else{
      $('#contact_telephone').css('border', 'solid 1px red');
    }
    if($('#contact_high_school').val()){
      count++;
    }else{
      $('#contact_high_school').css('border', 'solid 1px red');
    }
    if($('#contact_niveau').val()){
      count++;
    }else{
      $('#contact_niveau').css('border', 'solid 1px red');
    }
    if($('#contact_program_courses').val()){
      count++;
    }else{
      $('#contact_program_courses').css('border', 'solid 1px red');
    }
    if(count != 7){
      e.preventDefault();
    }
  });

});


/*
function randOrd() {
    return (Math.round(Math.random())-0.5); 
}

$(document).ready(function() {
    var klasses = [ 'img-one', 'img-two' ];
    klasses.sort( randOrd );
    $('.header-image').each(function(i, val) {
        $(this).addClass(klasses[i]);
    });
});
*/

function validateEmail($email) {
  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
  if( !emailReg.test( $email ) ) {
    return false;
  } else {
    return true;
  }
}


