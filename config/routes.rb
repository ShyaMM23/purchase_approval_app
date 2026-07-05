Rails.application.routes.draw do
  namespace :api do
    resources :purchase_requests, only: [:index, :show, :create, :update] do
      member do
        post :submit
        post :approve
        post :reject
      end
    end
  end
end
