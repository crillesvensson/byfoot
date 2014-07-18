Byfoot::Application.routes.draw do

  
  root to: "users#show"

  patch 'users/update/:id', to: 'users#update', as: :update_user

  devise_for :users

  resources :users, except: [:new ,:create, :destroy] 

  resources :places, except: [:show]

  get 'places/indexforplace/', to: 'places#userindex', as: :place_users

  get 'place/:id/:user_id', to: 'places#show', as: :show_place

  get 'places/findplace/', to: 'places#findplace', as: :find_place

  get 'places/showspot', to: 'places#showspot', as: :show_spot

  post 'places/:place_id/:id/addimage/', to:'places#addimage', as: :add_image

  get 'places/:user_id/:image_id/:place_id/showimage', to: 'places#showimage', as: :show_image

  get 'places/:image_id/:place_id/editimage', to: 'places#editimage', as: :edit_image

  patch 'places/:place_id/:place_id/updateimage/', to:'places#updateimage', as: :update_image

  delete 'places/:image_id/:place_id/deleteimage', to: 'places#destroyimage', as: :delete_image

  resources :messages, except: [:update]

  resources :friendships, except: [:update, :show, :new, :edit]


  #Create user controller and and comment out root path for devise to work
  #root to: "user#home"

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
