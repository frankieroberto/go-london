GoLondon::Application.routes.draw do

  resources :logs, :only => [:new, :create]

  root 'homepage#show'

end
