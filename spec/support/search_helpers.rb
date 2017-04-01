module SearchTestHelpers
  LIMIT = 3
  def stub_sem_search
    allow(Search).to receive(:run_sem_search).and_return(true)
  end
  def pre_create_search_results
    SearchResult.create(json: "{}",term: "iphone")
    SearchResult.where(term: "iphone")
  end
  def search_get_results_sets_limit
    stub_sem_search
    all_results = SearchResult.where(term: "iphone")
    expect(Search).to receive(:get_paginated_results)
                  .once.with(all_results,LIMIT,1)
    Search.get_results "iphone", 1
  end
  def search_get_results_formats_term
    stub_sem_search
    all_results = pre_create_search_results
    expect(Search).to receive(:get_paginated_results)
                  .once.with(all_results,LIMIT,1)
    Search.get_results "  IphOne ", 1
  end
  def search_get_results_runs_sem_search
    stub_sem_search
    expect(Search).to receive(:run_sem_search).once.with("iphone")
    Search.get_results "iphone", 1
  end
  def search_get_results_doesnt_call_runs_sem_search
    stub_sem_search
    all_results = pre_create_search_results
    expect(Search).not_to receive(:run_sem_search)
    Search.get_results "iphone", 1
  end
  def search_get_results_calls_get_paginated_results
    stub_sem_search
    all_results = pre_create_search_results
    expect(Search).to receive(:get_paginated_results)
                  .once.with(all_results,LIMIT,1)
    Search.get_results "iphone", 1
  end
  def search_get_results_calls_get_next_and_last_pages
    stub_sem_search
    all_results = pre_create_search_results
    expect(Search).to receive(:get_next_and_last_pages)
      .once.with(1,LIMIT,all_results.count).and_return({})
    Search.get_results "iphone", 1
  end
  def search_get_results_returns_hash
    stub_sem_search
    pages = {next_page: "next",last_page: "last"}
    expected_results = {
      results: "results",
      next_page: "next",
      last_page: "last",
      page: 1
    }
    allow(Search).to receive(:get_paginated_results).and_return("results")
    allow(Search).to receive(:get_next_and_last_pages).and_return(pages)
    expect(Search.get_results "iphone", 1).to eq(expected_results)
  end

end
