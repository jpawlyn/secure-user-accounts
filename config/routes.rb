Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  post 'otp', to: 'otp#create'
  get 'otp', to: 'otp#show', as: :otp_show
  put 'otp', to: 'otp#verify', as: :otp_verify
  delete 'otp', to: 'otp#delete', as: :otp_delete
end

