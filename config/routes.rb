Rails.application.routes.draw do
  get 'selections/list'
  get 'sessions_stud/new'
  get 'admins/hub'
  get 'presentations/list'
  get 'sessions/new'
  get 'schuelers/new'
  get 'users/new'
  root   'static_pages#home'

# Admin related sites
  get '/admin', to: 'admins#hub'
  get '/admin/add', to: 'admins#upload'
  get '/admin/add/presentations', to: 'presentations#add'
  get '/admin/add/students', to: 'schuelers#add'
  get '/admin/add/student', to: 'schuelers#new'
  post '/admin/add/student', to: 'schuelers#create'
  get '/admin/show/presentations', to: 'presentations#list'
  get '/admin/show/students', to: 'schuelers#list'
  get '/admin/show/admins', to: 'admins#list'
  get '/admin/new/admin', to: 'admins#new'
  post '/admin/new/admin', to: 'admins#create'
  get '/admin/reset', to: 'admins#reset'
  get '/admin/clear', to: 'admins#clear'


# Static Pages
  get '/hilfe', to: 'static_pages#hilfe'
  get '/impressum', to: 'static_pages#impressum'
  get '/kontakt', to: 'static_pages#kontakt'

# Admin session creation
  get '/admin/login', to: 'sessions#new'
  post '/admin/login', to: 'sessions#create'
  delete '/admin/login', to: 'sessions#destroy'

# Student session creation
  get '/studenten/anmelden', to: 'sessions#newstud'
  post '/studenten/anmelden', to: 'sessions#studcreate'
  delete '/studenten/anmelden', to: 'sessions#studdestroy'

  get '/studenten/waehlen', to: 'selections#list'


  resources :schuelers do
    collection { post :import }
  end
  resources :admins
  resources :presentations do
    collection { post :import }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
