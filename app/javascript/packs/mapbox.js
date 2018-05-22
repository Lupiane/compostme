import mapboxgl from 'mapbox-gl';
import { autocomplete } from '../components/autocomplete';

mapboxgl.accessToken = "pk.eyJ1IjoibHVwaWFuZSIsImEiOiJjamhobnlhNDgyM3loMzBzNjdlNjd0cDd4In0.Bi6PxCUwLgCJTlmZ6zjVEA";

const mapElement = document.getElementById('map');
if (mapElement) {
  var map = new mapboxgl.Map({
    container: 'map', // HTML container id
    style: 'mapbox://styles/mapbox/light-v9', // style URL
    center: [0, 0], // starting position as [lng, lat]
    zoom: 2
  });

  var markers = JSON.parse(mapElement.dataset.markers);

  markers.forEach(function(marker) {
   if (marker.infoWindow) {
        var popup = new mapboxgl.Popup()
        .setHTML(marker.infoWindow.content);
    };
    var mkr = new mapboxgl.Marker({ color: marker.color })
    .setLngLat([marker.lng, marker.lat])
    .setPopup(popup)
    .addTo(map);
  });

  if (mapElement.dataset.pubmrkrs != undefined) {
    const pubmrkrs = JSON.parse(mapElement.dataset.pubmrkrs);
    pubmrkrs.forEach(function(marker) {
      if (marker.infoWindow) {
        var popup = new mapboxgl.Popup()
        .setHTML(marker.infoWindow.content);
      };
      var mkr = new mapboxgl.Marker({ color: marker.color })
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(map);
    });
    markers = markers.concat(pubmrkrs);
  };

  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter({ lng: markers[0].lng, lat: markers[0].lat });
    map.setZoom(14);
  } else {
    var bounds = new mapboxgl.LngLatBounds();
    markers.forEach(function(marker) {
      bounds.extend([marker.lng, marker.lat]);
    });
    map.fitBounds(bounds, { padding: 60 });
  };
}

autocomplete();

