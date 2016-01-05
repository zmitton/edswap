$( document ).ready(function() {
  $('#preferred_contact_section [name="preferred_contact"]').on('click', function(){
    if( $('#text_button').prop('checked') || $('#call_button').prop('checked')){
      $('#phone_box').prop( "disabled", false);
      $('#email_box').prop( "disabled", true);
    }else{
      $('#email_box').prop( "disabled", false);
      $('#phone_box').prop( "disabled", true);
    }
  })
});
