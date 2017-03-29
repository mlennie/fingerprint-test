class Search

  def self.get_results raw_term, page
    page ||= 0
    limit = 3
    term = raw_term.downcase.strip
    count = SearchResult.where(term: term).count
    run_sem_search(term) if count == 0
    all_results = SearchResult.where(term: term)
    count = all_results.count
    results = all_results.limit(limit).offset(page * limit)
    results_so_far = page == 0 ? results.count : page * limit
    next_page = results_so_far < count ? page += 1 : nil
    {results: results, next_page: next_page}
  end

  def self.run_sem_search term
    sem = SemSearch.new term
    sem.search
  end
end
