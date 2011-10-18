Huanhao::Application.routes.draw do
 
  get "admin/dashboard"

  resources :users do
    collection do
      post :login
      get  :login
      get :logout
      
    end
  end

end
