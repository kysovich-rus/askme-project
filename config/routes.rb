Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions do
    member do # member - single instance, collection - all instances
      put :hide, :reveal
      patch :hide, :reveal
    end

  end
end
