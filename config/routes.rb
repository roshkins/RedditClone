RedditApp::Application.routes.draw do
  resource :session, :only => [:new,:destroy, :create ]

  resources :users, :only  => [:new, :create]

  resources :subs

  resources :links
end
