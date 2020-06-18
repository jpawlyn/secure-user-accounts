Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'users/sign_in_otp', to: 'users/sessions#new_with_otp'
    post 'users/sign_in_otp', to: 'users/sessions#create_with_otp'
  end

  root to: 'home#index'

  post 'otp', to: 'otp#create'
  get 'otp', to: 'otp#show', as: :otp_show
  put 'otp', to: 'otp#verify', as: :otp_verify
  delete 'otp', to: 'otp#delete', as: :otp_delete
end

