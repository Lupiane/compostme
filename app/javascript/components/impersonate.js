function selectUserToImpersonate() {
  document.addEventListener("DOMContentLoaded", function(){
    if (document.getElementById("userid")) {
      document.getElementById("userid").addEventListener("change", (e) => {
        var userId = e.target.value.charAt(0);
        document.getElementById("btn-imp").insertAdjacentHTML("afterbegin",
          `<a class='btn btn-success' data-method='post' href='/users/${userId}/impersonate/'>Go</a>`
          );
      })
    };
  })
}

export { selectUserToImpersonate } ;
