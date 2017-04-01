require 'rails_helper'

RSpec.describe Search, type: :model do

  describe "get_results" do
    it "should set page properly"
    it "sets limit to be 3"
    it "formats term correctly"
    it "calls run_sem_search when should"
    it "doesn't call run_sem_search when shouldn't"
    it "calls get_paginated_results with correct params"
    it "calls get_next_and_last_pages with correct params"
    it "returns hash with correct keys and values"
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

