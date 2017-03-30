class AdminCachesController < ApplicationController
  def show
  end

  def create
    CacheResultsJob.perform_later(params["search_term"])
    flash[:notice] = "Results from term: " + params["search_term"] + " are being cached"
    redirect_to admin_caches_path
  end
end
