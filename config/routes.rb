Rails.application.routes.draw do
  resources :articles
  root 'articles#home'
  get 'search', to: 'articles#search'
  post 'search', to: 'articles#create'
end
