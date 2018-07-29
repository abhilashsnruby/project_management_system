Rails.application.routes.draw do

  get 'dashboard/index'

  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' } do 
    get 'dashboard/index'
  end
  resources :tasks do
    get 'display_task_details', on: :collection
    get 'task_comment_page', on: :collection
  end
  resources :projects do
    get 'assign_tasks', on: :collection
    get 'project_tasks', on: :collection
  end
  
  root to: "dashboard#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
