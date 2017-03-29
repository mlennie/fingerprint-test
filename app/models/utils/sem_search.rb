require 'semantics3'

class SemSearch

  attr_accessor :client

  def initialize
    @client = Semantics3::Products.new(ENV["SEMANTIC_KEY"],ENV["SEMANTIC_SECRET"])
  end

  def self.search
    sem = self.new
    binding.pry
  end

end
