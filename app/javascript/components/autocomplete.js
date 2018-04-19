function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll('.compost_address').forEach((addressField) => {
      addressField.addEventListener("focus", (e) => {
        var compostAddress = e.currentTarget;
        if (compostAddress) {
          var autocomplete = new google.maps.places.Autocomplete(compostAddress, { types: [ 'geocode' ] });
          google.maps.event.addDomListener(compostAddress, 'keydown', function(e) {
            if (e.key === "Enter") {
              e.preventDefault(); // Do not submit the form on Enter.
            }
          });
        }
      });
    });
  });
}

export { autocomplete };

