Rails.application.routes.draw do

  # This defines a route so that when we recieve a get request with url: /home
  # Rails will invoke the WelcomeController with 'index' action
  # get({"/home" => "welcome#index"})
  root "welcome#index"
  get "/home" => "welcome#index"

  get "/about" => "welcome#about_us"

  get "/contact_us" => "contact_us#new"

  post "/contact_us" => "contact_us#create"

  resources :questions do
    # get :search, on: :collection
    # get :search, on: :member
    # get :search

    # This gives us a path with the question id
    resources :answers, only: [:create, :destroy]

    resources :likes, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
    # delete :destroy, on: :member
    # delete :destroy
  end
  # get     "/questions/new"       => "questions#new"
  # post    "/questions"           => "questions#create", as: :questions
  # get     "/questions/:id"       => "questions#show", as: :question
  # get     "/questions"           => "questions#index"
  # get     "/questions/:id/edit"  => "questions#edit", as: :edit_question
  # patch   "/questions/:id"       => "questions#update"
  # delete  "/questions/:id"       => "questions#destroy"

  # namespace :admin do
  #    get "questions" => "questions#index"
  # end

  # delete "/questions" => "questions#delete"

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
