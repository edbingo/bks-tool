Rails.application.routes.draw do
  get 'teachers/list'
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
  get '/admin/add/teachers', to: 'teachers#add'
  get '/admin/add/student', to: 'schuelers#new'
  post '/admin/add/student', to: 'schuelers#create'
  get '/admin/show/presentations', to: 'presentations#list'
  get '/admin/show/students/vn', to: 'schuelers#listfn'
  get '/admin/show/students/kl', to: 'schuelers#listkl'
  get '/admin/show/students/st', to: 'schuelers#listst'
  get '/admin/show/students', to: 'schuelers#list'
  get '/admin/show/admins', to: 'admins#list'
  get '/admin/show/teachers', to: 'teachers#list'
  get '/admin/new/admin', to: 'admins#new'
  post '/admin/new/admin', to: 'admins#create'
  get '/admin/reset', to: 'admins#reset'
  get '/admin/confirm', to: 'admins#warning'
  get '/admin/clear', to: 'admins#clear'
  get '/admin/send/login', to: 'admins#logindetailssend'
  get '/admin/send/list', to: 'admins#finallistsend'
  get '/admin/send/remind', to: 'admins#remindersend'


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
  post '/studenten/waehlen', to: 'selections#addtodb'
  get '/studenten/bestaetigen', to: 'selections#confirm'

  get '/studenten/waehlen/klasse', to:'selections#listk'
  get '/studenten/waehlen/titel', to:'selections#listt'
  get '/studenten/waehlen/fach', to:'selections#listf'
  get '/studenten/waehlen/betreuer', to:'selections#listb'
  get '/studenten/waehlen/zimmer', to:'selections#listz'
  get '/studenten/waehlen/zeit', to:'selections#listv'

  get '/studenten/profil', to: 'schuelers#show'
  post '/studenten/profil', to: 'schuelers#delfromdb'
  get '/studenten/profil/send', to: 'schuelers#confirm'
  post '/studenten/profil/send', to: 'schuelers#sendfile'
  get '/error', to: 'schuelers#fail'


  resources :schuelers do
    collection { post :import }
  end
  resources :admins
  resources :teachers do
    collection { post :import }
  end
  resources :presentations do
    collection { post :import }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
