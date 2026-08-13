Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker


  # LIST
  get  "lists",       to: "lists#index",  as: "lists"
  get  "lists/new",   to: "lists#new",    as: "new_list"
  get  "lists/:id",   to: "lists#show",   as: "list"
  post "lists",       to: "lists#create", as: "create_list"

  # BOOKMARK
  get  "lists/:list_id/bookmarks/new", to: "bookmarks#new",    as: "new_list_bookmark"
  post "lists/:list_id/bookmarks",     to: "bookmarks#create", as: "list_bookmarks"
  delete "bookmarks/:id",              to: "bookmarks#destroy", as: "bookmark"

  # root "controller_name#action_name"
end
