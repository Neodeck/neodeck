Rails.application.routes.draw do
  root 'main#index'

  get 'donate' => 'main#donate'

  get 'auth' => 'auth#login'
  get 'signup' => 'auth#signup'
  get 'logout' => 'auth#logout'
  post 'auth' => 'auth#auth'
  post 'signup' => 'auth#newuser'

  resources :decks
  resources :users

  get 'session/:session_id/:session_token' => 'decks#edit_session'

  get 'socket_api/user_with_token/:socket_token' => 'socket_api#user_with_token'
  get 'socket_api/has_access_to_deck/:socket_token/:deck_id' => 'socket_api#has_access_to_deck'
  post 'socket_api/save_deck' => 'socket_api#save_deck'

  get 'api/deck/:id' => 'public_api#deck'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
