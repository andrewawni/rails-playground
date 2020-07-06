Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  scope '/auth' do
    post '/signin', to: 'user_token#create'
    post '/signup', to: 'users#create'
   end

  resources :users do
    get :avatar, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :todos do
    resources :items
  end
end
