class SearchController < ApplicationController

  def show

  end

  def create
    results = Search.get_results params["search_term"]
    binding.pry
  end
end
