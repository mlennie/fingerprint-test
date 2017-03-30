require 'semantics3'
require 'json'

class SemSearch

  KEY = ENV["SEMANTIC_KEY"]
  SECRET = ENV["SEMANTIC_SECRET"]

  attr_accessor :client, :term, :results

  def initialize term
    @client = Semantics3::Products.new( KEY, SECRET )
    @term = term
  end

  def search
    prepare_search
    return search_and_cache ? self.results : false
  end

  def search_and_cache
    begin
      resultsHash = self.client.get_products()
    rescue
      return false
    end
    self.results = resultsHash["results"]
    self.cache_results
    return true
  end

  def prepare_search
    self.client.products_field( "search", self.term )
  end

  def cache_results
    ActiveRecord::Base.transaction do
      self.results.each do |result|
        SearchResult.create(json: result.to_json, term: term)
      end
      return true
    end
  end

end
