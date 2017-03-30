class Search

  def self.get_results raw_term, page
    page ||= 1
    limit = 3
    term = raw_term.downcase.strip

    run_sem_search(term) unless SearchResult.find_by(term: term)

    all_results = SearchResult.where(term: term)
    count = all_results.count

    results = all_results.limit(limit).offset((page - 1) * limit)
    next_page = (page * limit) < count ? page += 1 : nil

    { results: results, next_page: next_page }
  end

  def self.run_sem_search term
    sem = SemSearch.new term
    sem.search
  end

  def self.search_and_cache term
    term = params["search_term"].downcase.strip
    ActiveRecord::Base.transaction do
      SearchResult.where(term: term).destroy_all
      Search.run_sem_search(term)
    end
  end
end
