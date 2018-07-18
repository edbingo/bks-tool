Rails.application.routes.draw do
  get 'schuelers/new'
  get 'users/new'
  root   'static_pages#home'
  get    '/hilfe',      to: 'static_pages#hilfe'
  get    '/impressum',  to: 'static_pages#impressum'
  get    '/kontakt',    to: 'static_pages#kontakt'

  resources :schuelers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
