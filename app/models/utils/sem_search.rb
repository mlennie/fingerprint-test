require 'semantics3'
require 'json'

class SemSearch

  KEY = ENV["SEMANTIC_KEY"]
  SECRET = ENV["SEMANTIC_SECRET"]

  attr_accessor :client, :term, :results

  def initialize
    @client = Semantics3::Products.new( KEY, SECRET )
  end

  def search raw_term
    prepare_search raw_term
    search_and_cache
  end

  def search_and_cache
    resultsHash = self.client.get_products()
    self.results = resultsHash["results"]
    self.cache_results
  end

  def prepare_search raw_term
    self.term = raw_term.downcase.strip
    self.client.products_field( "search", self.term )
  end

  def cache_results
    self.results.each do |result|
      SearchResult.create(json: result.to_json, term: term)
    end
  end

end
