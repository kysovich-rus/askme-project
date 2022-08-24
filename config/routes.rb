Rails.application.routes.draw do
  get 'sessions/create'
  get 'sessions/new'
  get 'users/create'
  get 'users/new'
  root to: 'questions#index'

  resources :questions do
    member do # member - single instance, collection - all instances
      put :toggle
      patch :toggle
    end
  end

  resources :users, except: %i[index], param: :nickname
  resource :session
end
