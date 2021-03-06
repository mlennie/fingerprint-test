require 'rails_helper'

RSpec.describe SemSearch, type: :model do

  describe "initialize" do
    it "should set term property" do
     sem_search_initialize_sets_term_helper
    end
    it "should set client property" do
     sem_search_initialize_sets_client_helper
    end
  end

  describe "search" do
    it "calls prepare search" do
      sem_search_search_calls_prepare_search_helper
    end
    it "calls search_and_cache" do
      sem_search_search_calls_search_and_cache_helper
    end
    it "returns results if search_and_cache is true" do
      sem_search_search_returns_results_helper
    end
    it "returns false if search_and_cache is not true" do
      sem_search_search_returns_false_helper
    end
  end

  describe "search_and_cache" do
    it "calls get_products on sem.client" do
      sem_search_search_and_cache_calls_get_products_helper
    end
    it "returns false when get_products throws and exception" do
      sem_search_and_cache_returns_false_for_exception_helper
    end
    it "stores results key of get_products into self.results" do
      sem_search_stores_results_from_get_products_helper
    end
    it "calls cache_results" do
      sem_search_and_cache_calls_cache_results_helper
    end
    it "returns value of cache_results" do
      sem_search_and_cache_returns_cache_results_helper
    end
  end

  describe "prepare_search" do
    it "calls products_field with correct params and returns result" do
      sem_search_prepare_search_calls_products_field_helper
    end
  end

  describe "cache_results" do
    it "returns false if results are nil" do
      sem_cache_results_returns_false_if_results_nil_helper
    end
    it "returns false if results are empty" do
      sem_cache_results_returns_false_if_results_empty_helper
    end
    it "creates a SearchResult for each result" do
      sem_cache_results_creates_search_results_helper
    end
    it "returns true" do
      sem_cache_results_returns_true_helper
    end
  end
end

