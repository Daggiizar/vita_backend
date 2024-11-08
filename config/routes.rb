Rails.application.routes.draw do
  get 'price', to: 'prices#show'
  resources :transactions, only: [:create, :index, :show]
end
