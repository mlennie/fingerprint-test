require 'rails_helper'

RSpec.describe Search, type: :model do

  describe "get_results" do
    it "sets limit to be 3" do
      search_get_results_sets_limit
    end
    it "formats term correctly" do
      search_get_results_formats_term
    end
    it "calls run_sem_search when should" do
      search_get_results_runs_sem_search
    end
    it "doesn't call run_sem_search when shouldn't" do
      search_get_results_doesnt_call_runs_sem_search
    end
    it "calls get_paginated_results with correct params" do
      search_get_results_calls_get_paginated_results
    end
    it "calls get_next_and_last_pages with correct params" do
      search_get_results_calls_get_next_and_last_pages
    end
    it "returns hash with correct keys and values" do
      search_get_results_returns_hash
    end
  end

  describe "get_paginated_results" do
    it "returns false when there are no all_results"
    it "returns correct results through limit and offset"
  end

  describe "get_next_and_last_pages" do
    it "returns nil next_page when it should"
    it "returns nil last_page when it should"
    it "should return correct next_page when not nil"
    it "should return correct last_page when not nil"
  end

  describe "run_sem_search" do
    it "instantiates a SemSearch with correct param"
    it "calls search on intantiated SemSearch"
  end

  describe "search_and_cache" do
    it "destroys all search results with correct term"
    it "calls Search.run_sem_search with correct params"
    it "returns true"
  end

end

