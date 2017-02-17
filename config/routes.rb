Rails.application.routes.draw do
  get 'sessions/new'

  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/home',    to: 'static_pages#home'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post 'invoices/bill/:id' => 'invoices#bill', :as => :bill
  post 'emissions/showpdf/:id' => 'emissions#showpdf', :as => :showpdf


  resources :users do
    member do
      get :meditions, :transactions
    end
  end

  resources :transactions do
    member do
      get :users
    end
  end

  resources :meditions do
    member do
      get :users
    end
  end

  resources :emissions do
    member do
      get :meditions
      get :consumes
    end
  end

  resources :consumes
  resources :invoices

end
