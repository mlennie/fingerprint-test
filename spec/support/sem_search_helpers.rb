module SemSearchTestHelpers

  class Client
    def get_products
      return "products"
    end
  end

  def create_sem_helper
    key = ENV["SEMANTIC_KEY"]
    secret = ENV["SEMANTIC_SECRET"]
    @client = Client.new
    allow(Semantics3::Products).to receive(:new).with(key,secret).and_return(@client)
    SemSearch.new "iphone"
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

  def sem_search_search_calls_search_and_cache_helper
    sem = create_sem_helper
    allow(sem).to receive(:prepare_search).once
    expect(sem).to receive(:search_and_cache).once
    sem.search
  end

  def sem_search_search_returns_results_helper
    sem = create_sem_helper
    allow(sem).to receive(:prepare_search).once
    allow(sem).to receive(:search_and_cache).and_return(true)
    sem.results = "results"
    expect(sem.search).to eq("results")
  end

  def sem_search_search_returns_false_helper
    sem = create_sem_helper
    allow(sem).to receive(:prepare_search).once
    allow(sem).to receive(:search_and_cache).and_return(false)
    sem.results = "results"
    expect(sem.search).to eq(false)
  end

end
