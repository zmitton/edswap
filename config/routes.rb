Rails.application.routes.draw do
  get 'users/:id',      to: 'users#show', as: 'user'
  post 'users', to: 'users#create', as: 'user_create'
  post 'mail', to: 'mail#route', as: 'mail'
  get 'splash', to: 'welcome#splash', as: 'splash'

  resources :listings
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'welcome#splash'
  # root to: 'welcome#index'
  root to: ENV['ROOT_PAGE']


  resources :sessions, only: [:new, :create, :destroy, :show]
  get 'login', to: 'users#new', as: 'login'
  get 'auth/failure', to: redirect('/')
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'mission', to: 'mission#show', as: 'mission'

  
  get 'create_password_reset', to: 'users#create_password_reset', as: 'create_password_reset'
  get 'reset_password', to: 'users#reset_password', as: 'reset_password'
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
