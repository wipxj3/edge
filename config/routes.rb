Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "tracks#index", as: "authenticated_user"
  end

  root to: "pages#landing"

  resources :tracks do
    get "refresh"
  end
end
