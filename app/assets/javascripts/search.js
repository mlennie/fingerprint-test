$(document).ready(function() {

  function searchSubmit(e) {
    $(".fa-spinner").show();
    e.preventDefault();
    var searchTerm = $("#search_term").val();
    if (!searchTerm || searchTerm.length < 3) {
      alert("Please enter at least 3 characters");
      $(".fa-spinner").hide();
      return;
    }
    getResults(searchTerm);
  }

  function getResults(term) {
    var data = JSON.stringify({"search_term":term});
    $.ajax({
      url: "search",
      method: "POST",
      data: data,
      dataType: "script",
      contentType: "application/json;charset=utf-8",
    })
    .done(function(data) {
      $(".fa-spinner").hide()
      handleResults(data);
    })
    .fail(function(err) {
      $(".fa-spinner").hide()
      alert("There was an issue finding results. Please try again soon");
    });
  }

  function handleResults(data) {
    $("#results-table").append(JSON.parse(data));
  }

  function submitListener() {
    document.forms[0]
            .addEventListener("submit", searchSubmit);
  }

  submitListener();

})

