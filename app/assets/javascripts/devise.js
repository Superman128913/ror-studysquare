$(function() {

function labels_scholier(){
  var text_scholier_2 = '<abbr title="verplicht">*</abbr> Niveau';
  var text_scholier_3 = '<abbr title="verplicht">*</abbr> Jaar';
  var text_scholier_1 = '<abbr title="verplicht">*</abbr> Middelbare School';
  $(".user_institute").find('label').html(text_scholier_1);
  $(".user_faculty").find('label').html(text_scholier_2);
  $(".user_faculty_program").find('label').html(text_scholier_3);
}

function labels_student(){
  var text_student_2 = '<abbr title="verplicht">*</abbr> Faculteit';
  var text_student_3 = '<abbr title="verplicht">*</abbr> Opleiding';
  var text_student_1 = '<abbr title="verplicht">*</abbr> Instituut';
  $(".user_institute").find('label').html(text_student_1);
  $(".user_faculty").find('label').html(text_student_2);
  $(".user_faculty_program").find('label').html(text_student_3);
}


if ( $("body").find('.alert-error').length > 0 ){
  if ( $( "#user_institute_id" ).val() == '' ) {
    $( "#user_institute_id" ).closest( ".control-group" ).addClass('error');
  }
  if ( $( "#user_faculty_id" ).val() == '' ) {
    $( "#user_faculty_id" ).closest( ".control-group" ).addClass('error');
  }
  if ( $( "#user_faculty_program_id" ).val() == '' ) {
    $( "#user_faculty_program_id" ).closest( ".control-group" ).addClass('error');
  }
}


// $(".scholier").each(function() { $(this).appendTo("select#user_institute_id.select.required"); });

if ( $( "#user_institute_id" ).val() == '' ) {
  institute_select();
} else{
  if ( $('#user_institute_id').length ){
    if($('#user_institute_id').find('option:selected').attr("class").search('scholier') == 0){
      $("#scholiercheck").click();
      labels_scholier();
      $(".institute_select").each(function() { $(this).appendTo("#store"); });
      $(".scholier").each(function() { $(this).appendTo("select#user_institute_id.select.required"); });
      // $(".scholier").each(function() { $(this).show(); console.log('show'); });
    } else{
      $(".institute_select").each(function() { $(this).appendTo("#store"); });
      $(".student").each(function() { $(this).appendTo("select#user_institute_id.select.required"); });
      // $(".student").each(function() { $(this).show(); console.log('show'); });
    } 
  }
  faculty_select( $( "#user_institute_id" ).val(), 'yes' );
  faculty_program_select($( "#user_faculty_id" ).val(), 'yes');
}

$("input[name=type]").click(function() {
  institute_select();
});

$( "#user_institute_id" ).change(function() {
  faculty_select($( "#user_institute_id" ).val(), 'no');
});

$( "#user_faculty_id" ).change(function() {
  faculty_program_select($( "#user_faculty_id" ).val(), 'no');
});


function institute_select() {
  $(".institute_select:selected").removeAttr("selected");
  $(".faculty_program_select:selected").removeAttr("selected");
  $(".faculty_select:selected").removeAttr("selected");
  // $(".institute_select").each(function() { $(this).hide(); console.log('hide'); });
  $(".institute_select").each(function() { $(this).appendTo("#store"); });

  if ($("input[name=type]:checked").val() === 'scholier') {
    labels_scholier();
    faculty_select('niks', 'no');
    faculty_program_select('niks', 'no');
    $(".scholier").each(function() { $(this).appendTo("select#user_institute_id.select.required"); });
    // $(".scholier").each(function() { $(this).show(); console.log('show'); });
  } else {
    labels_student();
    faculty_select('niks', 'no');
    faculty_program_select('niks', 'no');
    $(".student").each(function() { $(this).appendTo("select#user_institute_id.select.required"); });
    // $(".student").each(function() { $(this).show(); console.log('show'); });
  }
}

function faculty_select(institute_id, reload) {
  if (reload != 'yes'){
    $(".faculty_select:selected").removeAttr("selected");
    $(".faculty_program_select:selected").removeAttr("selected");
  }
  $(".faculty_select").each(function() { $(this).appendTo("#store"); });
  $(".institute_" + institute_id).each(function() { $(this).appendTo("select#user_faculty_id"); });
  // $(".faculty_select").each(function() { $(this).hide(); console.log('hide'); });
  // $(".institute_" + institute_id).each(function() { $(this).show(); console.log('show'); });
}

function faculty_program_select(faculty_id, reload) {
  if (reload != 'yes'){
    $(".faculty_program_select:selected").removeAttr("selected");
  }
  $(".faculty_program_select").each(function() { $(this).appendTo("#store"); });
  $(".faculty_" + faculty_id).each(function() { $(this).appendTo("select#user_faculty_program_id"); });
  // $(".faculty_program_select").each(function() { $(this).hide(); console.log('hide'); });
  // $(".faculty_" + faculty_id).each(function() { $(this).show(); console.log('show'); });
}
});