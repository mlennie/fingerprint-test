class AdminCachesController < ApplicationController
  def show
  end

  def create
    if Search.search_and_cache params["search_term"]
      message = 'Results from term are being cached'
    else
      message = "There was an issue and results could not be cached." +
                " Please try again soon"
    end
    flash[:notice] = message
    redirect_to admin_caches_path
  end
end
