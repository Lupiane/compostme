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

// IN PROGRESS: make JS work on autocomplete inide iteration of all composts in admin dashboard
  // document.addEventListener("DOMContentLoaded", function() {
  //   var address = document.querySelectorAll('.data-address');

  //  here address is a NodeList : JS to be applied to each element of the list....

  //   if (address) {
  //     var autocomplete = new google.maps.places.Autocomplete(address, { types: [ 'geocode' ] });
  //     google.maps.event.addDomListener(address, 'keydown', function(e) {
  //       if (e.key === "Enter") {
  //         e.preventDefault(); // Do not submit the form on Enter.
  //       }
  //     });
  //   }
  // });


// IN PROGRESS: make JS work for form loading inside modals
//  .....
}

export { autocomplete };
