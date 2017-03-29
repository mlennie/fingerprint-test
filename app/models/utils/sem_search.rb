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
    search_and_cache
    self.results
  end

  def search_and_cache
    resultsHash = self.client.get_products()
    self.results = resultsHash["results"]
    self.cache_results
  end

  def prepare_search
    self.client.products_field( "search", self.term )
  end

  def cache_results
    self.results.each do |result|
      SearchResult.create(json: result.to_json, term: term)
    end
  end

end
