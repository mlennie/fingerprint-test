class CacheResultsJob < ApplicationJob
  queue_as :default

  def perform(search_term)
    Search.search_and_cache search_term
  end
end
