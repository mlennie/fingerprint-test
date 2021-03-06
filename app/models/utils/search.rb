class Search

  def self.get_results raw_term, page
    limit = 3
    term = raw_term.downcase.strip

    run_sem_search(term) unless SearchResult.find_by(term: term)
    all_results = SearchResult.where(term: term)
    results = get_paginated_results(all_results, limit, page)
    pages = get_next_and_last_pages(page, limit, all_results.count)

    { results: results,
      next_page: pages[:next_page],
      last_page: pages[:last_page],
      page: page
    }
  end

  def self.get_paginated_results all_results, limit, page
    if all_results.any?
      return all_results.limit(limit).offset((page - 1) * limit)
    else
      return false
    end
  end

  def self.get_next_and_last_pages page, limit, count
    next_page = (page * limit) < count ? page + 1 : nil
    last_page = page > 1 ? page - 1 : nil
    {last_page: last_page, next_page: next_page }
  end

  def self.run_sem_search term
    sem = SemSearch.new term
    sem.search
  end

  def self.search_and_cache raw_term
    term = raw_term.downcase.strip
    ActiveRecord::Base.transaction do
      SearchResult.where(term: term).destroy_all
      Search.run_sem_search(term)
      return true
    end
  end
end

