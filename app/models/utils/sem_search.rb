require 'semantics3'
require 'json'

class SemSearch

  attr_accessor :client, :term, :results

  def initialize
    @client = Semantics3::Products.new(ENV["SEMANTIC_KEY"],ENV["SEMANTIC_SECRET"])
  end

  def self.search raw_term
    sem = self.new
    sem.prepare_search raw_term
    sem.search_and_cache
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
      json = result.to_json
      SearchResult.create(json: json, term: term)
    end
  end

end
