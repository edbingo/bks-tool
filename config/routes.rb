Rails.application.routes.draw do
  get 'sessions/new'
  get 'schuelers/new'
  get 'users/new'
  root   'static_pages#home'
  get    '/hilfe',      to: 'static_pages#hilfe'
  get    '/impressum',  to: 'static_pages#impressum'
  get    '/kontakt',    to: 'static_pages#kontakt'
  get    '/login',      to: 'sessions#new'
  post   '/login',      to: 'sessions#create'
  delete '/login',      to: 'sessions#destroy'
  get    '/signup',     to: 'schuelers#new'
  post   '/signup',     to: 'schuelers#create'

  resources :schuelers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
