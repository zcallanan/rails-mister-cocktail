Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :cocktails, only: %i[index show new create edit update] do
    resources :doses, only: %i[new create]
  end
  resources :doses, only: :destroy
end
