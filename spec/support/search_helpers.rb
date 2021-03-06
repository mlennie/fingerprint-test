module SearchTestHelpers

  class SemTest
    def search
      return true
    end
  end

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
  def search_get_paginated_results_returns_false
    all_results = SearchResult.all
    response = Search.get_paginated_results all_results, LIMIT, 1
    expect(response).to eq false
  end
  def search_get_paginated_results_returns_correct_records
    result_1 = SearchResult.create(json: "one",term: "iphone")
    result_2 = SearchResult.create(json: "two",term: "iphone")
    result_3 = SearchResult.create(json: "three",term: "iphone")
    result_4 = SearchResult.create(json: "four",term: "iphone")
    result_5 = SearchResult.create(json: "five",term: "iphone")
    all_results = SearchResult.all
    results = Search.get_paginated_results all_results, 2, 2
    expect(results.count).to eq 2
    expect(results.first).to eq result_3
    expect(results.last).to eq result_4
  end
  def search_run_sem_search_instantiates_sem
    sem = SemTest.new
    expect(SemSearch).to receive(:new).once.with("iphone").and_return(sem)
    Search.run_sem_search "iphone"
  end
  def search_run_sem_search_calls_search
    sem = SemTest.new
    allow(SemSearch).to receive(:new).and_return(sem)
    expect(sem).to receive(:search)
    Search.run_sem_search "iphone"
  end
  def get_next_and_last_returns_nil_next_page
    result = Search.get_next_and_last_pages 2, 5, 9
    expect(result[:next_page]).to be_nil
  end
  def get_next_and_last_returns_nil_last_page
    result = Search.get_next_and_last_pages 1, 5, 11
    expect(result[:last_page]).to be_nil
  end
  def get_next_and_last_returns_non_nil_next_page
    result = Search.get_next_and_last_pages 2, 5, 11
    expect(result[:next_page]).to eq 3
  end
  def get_next_and_last_returns_non_nil_last_page
    result = Search.get_next_and_last_pages 2, 5, 10
    expect(result[:last_page]).to eq 1
  end
  def search_search_and_cache_destroys_results
    stub_sem_search
    SearchResult.create(json: "one",term:"iphone")
    SearchResult.create(json: "two",term:"iphone")
    result_3 = SearchResult.create(json: "three",term:"not iphone")

    Search.search_and_cache "iphone"

    expect(SearchResult.count).to eq 1
    expect(SearchResult.first).to eq result_3
  end
  def search_search_and_cache_calls_run_sem_search
    stub_sem_search
    expect(Search).to receive(:run_sem_search).once.with("iphone")
    Search.search_and_cache "iphone"
  end
  def search_search_and_cache_returns_true
    stub_sem_search
    result = Search.search_and_cache "iphone"
    expect(result).to eq(true)
  end

end
