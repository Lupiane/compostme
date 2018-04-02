function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var compostAddress = document.getElementById('compost_address');

    if (compostAddress) {
      var autocomplete = new google.maps.places.Autocomplete(compostAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(compostAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
  // var modal = document.querySelector("#modal")
  // modal.addEventListener("", function() {
  //   console.log("Hello JS!")
  //   var compostAddress = document.getElementById('compost_address');

  //   if (compostAddress) {
  //     var autocomplete = new google.maps.places.Autocomplete(compostAddress, { types: [ 'geocode' ] });
  //     google.maps.event.addDomListener(compostAddress, 'keydown', function(e) {
  //       if (e.key === "Enter") {
  //         e.preventDefault(); // Do not submit the form on Enter.
  //       }
  //     });
  //   }
  // });
}

export { autocomplete };
