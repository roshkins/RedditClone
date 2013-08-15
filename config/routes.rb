RedditApp::Application.routes.draw do
  resource :session

  resources :users
end
