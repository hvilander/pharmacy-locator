Rails.application.routes.draw do
  root 'homepage#index'
  get 'pharmacy', to: 'pharmacy#show'
end
