class SearchController < ApplicationController

  def show

  end

  def create
    results = Search.get_results params["search_term"]
    respond_to do |format|
      format.html
      format.js { render "search/search_results", locals: {results: results} }
    end

  end
end
