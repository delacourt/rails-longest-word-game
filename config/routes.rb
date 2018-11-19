Rails.application.routes.draw do
  root to: 'games#new'
  post 'score', to: 'games#score', as: :score
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
