Rails.application.routes.draw do
  get 'admins/hub'
  get 'presentations/list'
  get 'sessions/new'
  get 'schuelers/new'
  get 'users/new'
  root   'static_pages#home'

# Admin related sites
  get    '/adminhub', to: 'admins#hub'
  get    '/adminhub/add/presentations', to: 'presentations#add'
  get    '/adminhub/add/students', to: 'schuelers#add'
  get    '/adminhub/add/student', to: 'schuelers#new'
  post   '/adminhub/add/student', to: 'schuelers#create'
  get    '/adminhub/show/presentations', to: 'presentations#list'
  get    '/adminhub/show/students', to: 'schuelers#list'
  get    '/adminhub/show/admins', to: 'admins#list' 
  get    '/adminhub/new/admin', to: 'admins#new'
  post   '/adminhub/new/admin', to: 'admins#create'


# Static Pages
  get    '/hilfe',          to: 'static_pages#hilfe'
  get    '/impressum',      to: 'static_pages#impressum'
  get    '/kontakt',        to: 'static_pages#kontakt'

# Admin session creation
  get    '/admin/login', to: 'sessions#new'
  post   '/admin/login', to: 'sessions#create'
  delete '/admin/login', to: 'sessions#destroy'

# Student related sites
  get    '/studenten/anmelden',     to: 'sessions#stud'
  post   '/studenten/anmelden',     to: 'sessions#screate'
  delete '/studenten/anmelden',     to: 'sessions#sdestroy'


  resources :schuelers do
    collection { post :import }
  end
  resources :admins
  resources :presentations do
    collection { post :import }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
