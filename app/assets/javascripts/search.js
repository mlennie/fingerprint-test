$(document).ready(function() {

  var searchTerm,page;

  function searchSubmit(e) {
    $(".fa-spinner").show();
    e.preventDefault();
    searchTerm = $("#search_term").val();
    if (!searchTerm || searchTerm.length < 3) {
      alert("Please enter at least 3 characters");
      $(".fa-spinner").hide();
      return;
    }
    getResults(searchTerm);
  }

  function getResults() {
    var data = JSON.stringify({"search_term":searchTerm,"page": page});
    $.ajax({
      url: "search",
      method: "POST",
      data: data,
      dataType: "script",
      contentType: "application/json;charset=utf-8",
    })
    .done(function(data) {
      $(".fa-spinner").hide()
      if (!data || !data.results) {
        alert("There was an issue finding results. Please try again soon");
        return;
      }
      handleResults(data);
    })
    .fail(function(err) {
      $(".fa-spinner").hide()
      alert("There was an issue finding results. Please try again soon");
    });
  }

  function handleResults(data) {
    $("#next-button").remove();
    $("#page-number").remove();
    if (!page) {
      $("#results-table").empty();
      $("#results-table").html("<td>Price</td>");
    }
    $("#results-table").append(JSON.parse(data));
    var pageEl = $("#page-number");
    if (pageEl && pageEl.data() && pageEl.data().page) {
      page = pageEl.data().page;
      $("#results-table").after("<button id='next-button'>View More</button>");

    }
    nextButtonListener();
  }

  function submitListener() {
    document.forms[0]
      .addEventListener("submit", function(e) {
        page = null;
        searchSubmit(e);
      });
  }

  function nextButtonListener() {
    $("#next-button").on("click",searchSubmit);
  }

  submitListener();

})

