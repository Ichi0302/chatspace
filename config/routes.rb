Rails.application.routes.draw do
  root 'top#index'
  devise_for :users
  resources :groups, only: %i(new edit)
  post "/chat_groups" => "groups#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
