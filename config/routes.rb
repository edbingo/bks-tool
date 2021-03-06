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
  get '/presentation/pres', to: 'presentations#pres'
  get '/teachers/download_pdf'

# Admin related sites
  get '/admin', to: 'admins#hub'
  get '/admin/opt', to: 'admins#manage'

  post '/admin/opt/free', to: 'admins#addfree'
  post '/admin/opt/reqs', to: 'admins#addreq'
  post '/admin/opt/time', to: 'admins#addtime'
  get '/admin/opt/off', to: 'admins#deactivate'
  get '/admin/opt/on', to: 'admins#activate'
# Setup process
  get '/admin/setup', to: 'admins#setup'
# Upload process for presentations
  get '/admin/add/presentations', to: 'presentations#add'
  post '/admin/add/presentations/free', to: 'presentations#addfree'
# Upload process for students
  get '/admin/add/students', to: 'schuelers#add'
  post '/admin/add/students/req', to: 'schuelers#addreq'
# Single student signup page
  get '/admin/add/student', to: 'schuelers#new'
  post '/admin/add/student', to: 'schuelers#create'
# Upload process for teachers
  get '/admin/add/teachers', to: 'teachers#add'
# Single teacher signup page
  get '/admin/add/teacher', to: 'teachers#new'
  post '/admin/add/teacher', to: 'teachers#create'
# Single admin signup page
  get '/admin/new/admin', to: 'admins#new'
  post '/admin/new/admin', to: 'admins#create'
# Single presentation add page
  get '/admin/new/presentation', to: 'presentations#new'
  post '/admin/new/presentation', to: 'presentations#create'
# Management tools for presentations
  get '/admin/show/presentations', to: 'presentations#list'
  post '/admin/show/presentations/edit', to: 'presentations#edit'
  post '/admin/show/presentations/update', to: 'presentations#update'
  post '/admin/show/presentations/remove', to: 'presentations#deleter'
# Management tools for students
  get '/admin/show/students', to: 'schuelers#list'
  post '/admin/show/students/edit', to: 'schuelers#edit'
  get '/admin/show/students/edit', to: 'schuelers#list'
  post '/admin/show/students/update', to: 'schuelers#update'
  get '/admin/show/students/update', to: 'schuelers#list'
  post '/admin/show/students/remove', to: 'schuelers#deleter'
  get '/admin/show/students/remove', to: 'schuelers#list'
  get '/admin/show/students/choice', to: 'schuelers#list'

  post '/admin/show/students/choice', to: 'schuelers#choices'

  post '/admin/force', to: 'admins#force'
# Management tools for admins
  get '/admin/show/admins', to: 'admins#list'
  get '/admin/show/admins/edit', to: 'admins#list'
  post '/admin/show/admins/edit', to: 'admins#edit'
  get '/admin/show/admins/update', to: 'admins#list'
  post '/admin/show/admins/update', to: 'admins#update'
  get '/admin/show/admins/remove', to: 'admins#list'
  post '/admin/show/admins/remove', to: 'admins#deleter'
# Management tools for teachers
  get '/admin/show/teachers', to: 'teachers#list'
  get '/admin/show/teachers/edit', to: 'teachers#list'
  post '/admin/show/teachers/edit', to: 'teachers#edit'
  get '/admin/show/teachers/update', to: 'teachers#list'
  post '/admin/show/teachers/update', to: 'teachers#update'
  get '/admin/show/teachers/remove', to: 'teachers#list'
  post '/admin/show/teachers/remove', to: 'teachers#deleter'
  get '/admin/show/teachers/pres', to: 'teachers#pres'
  post '/admin/show/teachers/pres', to: 'teachers#pres'
# System Management pages
  get '/admin/reset', to: 'admins#reset'
  get '/admin/confirm', to: 'admins#warning'
  get '/admin/clear', to: 'admins#clear'
# Mailer services
  get '/admin/send', to: 'admins#mailer'
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

  post '/studenten/force', to: 'sessions#force'

# Student session creation
  get '/studenten/anmelden', to: 'sessions#newstud'
  post '/studenten/anmelden', to: 'sessions#studcreate'
  delete '/studenten/anmelden', to: 'sessions#studdestroy'

  get '/studenten/waehlen', to: 'selections#list'
  post '/studenten/waehlen', to: 'selections#addtodb'
  get '/studenten/clean', to: 'selections#clean'
  get '/studenten/bestaetigen', to: 'selections#confirm'

  post '/studenten/weg', to: 'selections#weg'
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
