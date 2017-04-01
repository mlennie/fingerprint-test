require 'json'
module SemSearchTestHelpers

  class Client
    def get_products
      return {"results": "products"}
    end
    def products_field(action,term)
      return true
    end
  end

  def create_sem_helper
    key = ENV["SEMANTIC_KEY"]
    secret = ENV["SEMANTIC_SECRET"]
    @client = Client.new
    allow(Semantics3::Products).to receive(:new).with(key,secret).and_return(@client)
    SemSearch.new "iphone"
  end

  def sem_results_helper
    return {"results": "products"}
  end

  def sem_cache_results_returns_false_if_results_nil_helper
    sem = create_sem_helper
    sem.results = nil
    expect(sem.cache_results).to eq(false)
  end

  def sem_cache_results_returns_false_if_results_empty_helper
    sem = create_sem_helper
    sem.results = []
    expect(sem.cache_results).to eq(false)
  end

  def sem_cache_results_creates_search_results_helper
    sem = create_sem_helper
    sem.term = "iphone"
    results = [{test: 1,term: 1}, {test: 2,term: 2}]
    sem.results = results
    sem.cache_results
    expect(SearchResult.count).to eq(2)
    expect(SearchResult.first.json).to eq(results[0].to_json)
    expect(SearchResult.second.json).to eq(results[1].to_json)
    expect(SearchResult.first.term).to eq("iphone")
    expect(SearchResult.second.term).to eq("iphone")
  end

  def sem_cache_results_returns_true_helper
    sem = create_sem_helper
    sem.term = "iphone"
    results = [{test: 1,term: 1}, {test: 2,term: 2}]
    sem.results = results
    expect(sem.cache_results).to eq(true)
  end

  def sem_search_prepare_search_calls_products_field_helper
    sem = create_sem_helper
    expect(@client).to receive(:products_field).with("search","iphone").and_return("expected result")
    expect(sem.prepare_search).to eq("expected result")
  end

  def sem_search_and_cache_prepare_helper
    sem = create_sem_helper
    allow(@client).to receive(:get_products).once.and_return(sem_results_helper)
    allow(sem).to receive(:cache_results).once
    sem
  end

  def sem_search_search_and_cache_calls_get_products_helper
    sem = sem_search_and_cache_prepare_helper
    expect(@client).to receive(:get_products).once.and_return(sem_results_helper)
    sem.search_and_cache
  end

  def sem_search_and_cache_returns_false_for_exception_helper
    sem = sem_search_and_cache_prepare_helper
    allow(@client).to receive(:get_products).once.and_raise("error")
    expect(sem.search_and_cache).to eq false
  end

  def sem_search_stores_results_from_get_products_helper
    sem = sem_search_and_cache_prepare_helper
    expect(sem.results).to eq(nil)
    sem.search_and_cache
    expect(sem.results).to eq(sem_results_helper["results"])
  end

  def sem_search_and_cache_calls_cache_results_helper
    sem = sem_search_and_cache_prepare_helper
    expect(sem).to receive(:cache_results).once
    sem.search_and_cache
  end

  def sem_search_initialize_sets_term_helper
    sem = create_sem_helper
    expect(sem.term).to eq("iphone")
  end

  def sem_search_initialize_sets_client_helper
    sem = create_sem_helper
    expect(sem.client).to eq(@client)
  end

  def sem_search_search_calls_prepare_search_helper
    sem = create_sem_helper
    expect(sem).to receive(:prepare_search).once
    sem.search
  end

  def create_sem_and_call_prepare_search_helper
    sem = create_sem_helper
    allow(sem).to receive(:prepare_search).once
    sem
  end

  def sem_search_search_calls_search_and_cache_helper
    sem = create_sem_and_call_prepare_search_helper
    expect(sem).to receive(:search_and_cache).once
    sem.search
  end

  def sem_search_search_returns_results_helper
    sem = create_sem_and_call_prepare_search_helper
    allow(sem).to receive(:search_and_cache).and_return(true)
    sem.results = "results"
    expect(sem.search).to eq("results")
  end

  def sem_search_search_returns_false_helper
    sem = create_sem_and_call_prepare_search_helper
    allow(sem).to receive(:search_and_cache).and_return(false)
    sem.results = "results"
    expect(sem.search).to eq(false)
  end


end
