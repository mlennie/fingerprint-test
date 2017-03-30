class SearchesController < ApplicationController

  def show

  end

  def create
    results = Search.get_results params["search_term"], params["page"]
    respond_to do |format|
      format.html
      format.js { render "searches/search_results", locals: results }
    end
  end
end
