class Search

  def self.get_results raw_term
    term = raw_term.downcase.strip
    results = SearchResult.where(term: term)
    results = run_sem_search(term) if results.empty?
    results
  end

  def self.run_sem_search term
    sem = SemSearch.new term
    sem.search
  end
end
