Uribox::Application.routes.draw do
  devise_for :users, :controllers => {
    registrations: "users/registrations", passwords: "users/passwords"
  }

  devise_scope :user do
    get    "login",  to: "devise/sessions#new"
    delete "logout", to: "devise/sessions#destroy"
    get    "join",   to: "devise/registrations#new"
  end

  root to: 'home#index'

  get "home/index"
end
