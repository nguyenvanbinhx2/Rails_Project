Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :microposts, only: [:create, :destroy]
    resources :relationships, only: %i(index create destroy)
    resources :microposts, only: %i(create destroy)
    root "static_pages#home"
    get  "/help", to: "static_pages#help"
    get  "/about", to: "static_pages#about"
    get  "/contact", to: "static_pages#contact"
    get  "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to:"sessions#create"
    delete "logout", to: "sessions#destroy"
  end
end
