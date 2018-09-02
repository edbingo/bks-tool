Rails.application.routes.draw do
  get 'admins/hub'
  get 'presentations/list'
  get 'sessions/new'
  get 'schuelers/new'
  get 'users/new'
  root   'static_pages#home'
  get    '/studentenl',     to: 'sessions#stud'
  post   '/studentenl',     to: 'sessions#screate'
  delete '/studentenl',     to: 'sessions#sdestroy'
  get    '/addingpres',     to: 'presentations#add'
  get    '/liste',          to: 'presentations#list'
  get    '/hilfe',          to: 'static_pages#hilfe'
  get    '/impressum',      to: 'static_pages#impressum'
  get    '/kontakt',        to: 'static_pages#kontakt'
  get    '/anmeldung',      to: 'sessions#new'
  post   '/anmeldung',      to: 'sessions#create'
  delete '/anmeldung',      to: 'sessions#destroy'
  get    '/signup',         to: 'schuelers#new'
  post   '/signup',         to: 'schuelers#create'
  get    '/adminhub',       to: 'admins#hub'


  resources :schuelers
  resources :admins
  resources :presentations do
    collection { post :import }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
