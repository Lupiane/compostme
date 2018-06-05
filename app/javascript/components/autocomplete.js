import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from 'mapbox-gl-geocoder';

function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var addresses = document.querySelectorAll('.form-control.compost_address')
    mapboxgl.accessToken = 'pk.eyJ1IjoibHVwaWFuZSIsImEiOiJjamkxbHN2dXkwYzJkM2tzNzZqZGx3ZnZ0In0.OG1oUjCPBbtjwmyRZFU9nQ';

    if (addresses.length >= 1) {
      addresses.forEach((address) => {
        var compostId = address.id;
        var map = new mapboxgl.Map({
          container: `fakemap${compostId}`,
          style: 'mapbox://styles/mapbox/streets-v9',
          center: [-79.4512, 43.6568],
          zoom: 13
        });


        var geocoder = new MapboxGeocoder({
          accessToken: mapboxgl.accessToken,
          autocomplete: true,
          placeholder: "adresse"
        });

        document.getElementById(`geocoder${compostId}`).appendChild(geocoder.onAdd(map));

        if (address.value != "") {
          document.querySelector(`#geocoder${compostId} > .mapboxgl-ctrl-geocoder > input`).value = address.value;
        };

        document.querySelector(`#geocoder${compostId} > .mapboxgl-ctrl-geocoder > input`).addEventListener("change", function(e) {
          address.value = geocoder._typeahead.selected.place_name;
        })

      })
    };
  });
}

export { autocomplete };
