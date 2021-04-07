Rails.application.routes.draw do
  resources :articles
  root 'articles#index'
  get 'search', to: 'articles#search'
  post 'search', to: 'articles#search'
end
