$(".dropdown-list").hover(
  function () {
    $(this).addClass('expanded');
  }, 
  function () {
    $(this).removeClass('expanded');
  }
  );
  
  $(".dropdown-list").hover(
  function () {
    $('.main-list').addClass('no-bottom');
  }, 
  function () {
    $('.main-list').removeClass('no-bottom');
  }
  );

  
$(".main-list").hover(
  function () {
    $('.dropdown-list').addClass('expanded');
  }, 
  function () {
    $('.dropdown-list').removeClass('expanded');
  }
  );
  
  $(".main-list").hover(
  function () {
    $(this).addClass('no-bottom');
  }, 
  function () {
    $(this).removeClass('no-bottom');
  }
  );
  
/* FILTER       
  
if ( $(".ac-uni").hasClass("active")){
  $(".fac").addClass("exists");
};

if ( $(".ac-fac").hasClass("active")){
  $(".opl").addClass("exists");
};

if ( $(".ac-opl").hasClass("active")){
  $(".vak").addClass("exists");
};

*/
