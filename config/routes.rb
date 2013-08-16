RedditApp::Application.routes.draw do
  resource :session, :only => [:new,:destroy, :create ]

  resources :users, :only  => [:new, :create]

  resources :subs

  resources :links do
    resources :comments, :except => [:show, :edit, :index]
    post "upvote", :method => "Link#upvote"
    post "downvote", :method => "Link#downvote"
  end

end
