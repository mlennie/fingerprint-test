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
      if (!data) {
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
    //$("#next-button").remove();
    //$("#next-button").remove();
    $("#page-number").remove();
    $("#results-table").empty();
    $("#results-table").html(JSON.parse(data));
    nextButtonListener();
  }

  function submitListener() {
    $("#search-submit").on("click", function(e) {
      page = null;
      searchSubmit(e);
    });
  }

  function nextButtonListener() {
    $(".page-number").on("click", function(e) {
      if (this.dataset && this.dataset.page) {
        page = +this.dataset.page;
      }
      searchSubmit(e);
    });
  }

  submitListener();

})

