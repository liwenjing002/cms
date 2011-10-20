Huanhao::Application.routes.draw do
match '/', :to => 'homes#index'
  resources :events
  resources :homes do
      collection do
        get :forums
      end
  end
  resources :forums do
  collection do
  get :select_with_ajax
  post :select_with_ajax
  end
  end
  
  resources :articles


  get "admin/dashboard"

  resources :users do
    collection do
      post :login
      get  :login
      get :logout
      
    end
  end

end
