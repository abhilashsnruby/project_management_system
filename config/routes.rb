Rails.application.routes.draw do

  devise_for :users
  resources :tasks
  resources :projects, except: [:show] do
    get 'assign_tasks', on: :collection
  end
  
  root to: "projects#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
