Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions do
    member do # member - single instance, collection - all instances
      put :toggle
      patch :toggle
    end

  end
end
