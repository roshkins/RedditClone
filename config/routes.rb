RedditApp::Application.routes.draw do
  resource :session, :only => [:new,:destroy, :create ]

  resources :users, :only  => [:new, :create]

  resources :subs

  resources :links do
    resources :comments, :except => [:show, :edit, :index]
    post "upvote", :action => "Link#upvote"
    post "downvote", :action => "Link#downvote"
  end

end
