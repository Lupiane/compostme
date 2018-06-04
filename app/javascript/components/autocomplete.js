import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from 'mapbox-gl-geocoder';

function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var addresses = document.querySelectorAll('.compost_address')
    if (addresses.length >= 1) {
      mapboxgl.accessToken = 'pk.eyJ1IjoibHVwaWFuZSIsImEiOiJjamhobnlhNDgyM3loMzBzNjdlNjd0cDd4In0.Bi6PxCUwLgCJTlmZ6zjVEA';

      var map = new mapboxgl.Map({
        container: 'fakemap',
        style: 'mapbox://styles/mapbox/streets-v9',
        center: [-79.4512, 43.6568],
        zoom: 13
      });


      var geocoder = new MapboxGeocoder({
        accessToken: mapboxgl.accessToken,
        autocomplete: true
      });
    };

    addresses.forEach((addressField) => {
      addressField.addEventListener("focus", (e) => {
        var compostAddress = e.currentTarget;
        if (compostAddress) {
          // var autocomplete = new google.maps.places.Autocomplete(compostAddress, { types: [ 'geocode' ] });
          // google.maps.event.addDomListener(compostAddress, 'keydown', function(e) {
          //   if (e.key === "Enter") {
          //     e.preventDefault(); // Do not submit the form on Enter.
          //   }
          // });

          document.getElementById('geocoder').appendChild(geocoder.onAdd(map));
          document.querySelector(".mapboxgl-ctrl-geocoder > input").addEventListener("change", function(e) {
            console.log(geocoder._typeahead.selected.place_name);
            compostAddress.value = geocoder._typeahead.selected.place_name;
          })

          // query the geocoder

          // add event listener so query updates with user typing

          // geocoder.addDomListener(compostAddress, 'keydown', function(e) {
          //   if (e.key === "Enter") {
          //     e.preventDefault(); // Do not submit the form on Enter.
          //   }
          // });
        }
      });
    });
  });
}

export { autocomplete };

// <script>
// mapboxgl.accessToken = 'pk.eyJ1IjoibHVwaWFuZSIsImEiOiJjamhobnlhNDgyM3loMzBzNjdlNjd0cDd4In0.Bi6PxCUwLgCJTlmZ6zjVEA';

// var geocoder = new MapboxGeocoder({
//     accessToken: mapboxgl.accessToken
// });

// document.getElementById('geocoder').appendChild(geocoder.onAdd(map));
// </script>
