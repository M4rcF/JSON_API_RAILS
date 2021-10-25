Rails.application.routes.draw do
  #mount_devise_token_auth_for 'User', at: 'auth'
  resources :kinds
  resources :contacts do 
    resource :kind, only: [:show]
    resource :phones, only: [:show]
    resource :phones, only: [:update, :create, :destroy], path: "/phone"
    resource :address, only: [:show, :update, :create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
