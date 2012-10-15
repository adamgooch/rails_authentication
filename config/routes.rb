Pbkdf2Test::Application.routes.draw do
  resources :users
  match "/authenticate" => "users#authenticate"
end
