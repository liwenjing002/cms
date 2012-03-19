Huanhao::Application.routes.draw do
  resources :page_temps

  resources :course_types

  resources :courses

  resources :adds

  resources :friend_links

match '/', :to => 'homes#index'
match '/homes/forums/:id/:page',  
  :controller => 'homes',  
  :action => 'forums',  
  :requirements => {:id=>/\d+/,:page => /\d+/},  
  :page => nil ,
  :id => nil  

 match '/homes/articles/:id',  
  :controller => 'homes',  
  :action => 'articles',  
  :requirements => {:id=>/\d+/},  
  :id => nil   

match '/homes/forums/:id/',  
  :controller => 'homes',  
  :action => 'forums',  
  :requirements => {:id=>/\d+/},  
  :id => nil  

  resources :events
  resources :homes do
      collection do
        get :forums
        get :articles
        get :read
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
