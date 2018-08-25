Rails.application.routes.draw do
  get 'sessions/new'
  get 'schuelers/new'
  get 'users/new'
  root   'static_pages#home'
  get    '/hilfe',          to: 'static_pages#hilfe'
  get    '/impressum',      to: 'static_pages#impressum'
  get    '/kontakt',        to: 'static_pages#kontakt'
  get    '/anmeldung',      to: 'sessions#new'
  post   '/anmeldung',      to: 'sessions#create'
  delete '/anmeldung',      to: 'sessions#destroy'
  get    '/signup',         to: 'schuelers#new'
  post   '/signup',         to: 'schuelers#create'

  resources :schuelers
  resources :admins

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
