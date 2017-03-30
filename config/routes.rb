Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "searches#show"
  post '/search', to: "searches#create"

  get '/admin_caches', to: "admin_caches#show"
  post '/admin_caches', to: "admin_caches#create"
end
