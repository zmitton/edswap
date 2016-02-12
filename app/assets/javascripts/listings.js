$( document ).ready(function() {
  initMap();
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

function initMap() {
  var mapProp = {
    center: new google.maps.LatLng(37.79, -122.3131),
    zoom: 11,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: false,
  };
  var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
  var geocoder = new google.maps.Geocoder();
  var locations = $('.location');
  var addresses = [];
  for(var i = 0 ; i < locations.length ; i++){
    var address = locations[i].innerHTML;
    geocoder.geocode( {'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location
        });
      }
    });
    // var marker = new google.maps.Marker({
    //   position: {lat: 37.79, lng: -122.3131},
    //   map: map,
    //   title: 'Hello World!'
    // });
  }
}
