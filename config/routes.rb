Rails.application.routes.draw do

  get 'users/index'

  get 'dashboard/index'

  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' } do 
    get 'dashboard/index'
  end
  resources :tasks do
    get 'display_task_details', on: :collection
    get 'task_comment_page', on: :collection
  end

  resources :projects do
    post 'populate_projects', on: :collection
    get 'assign_tasks', on: :collection
    get 'project_tasks', on: :collection
    get 'assign_projects_to_users', on: :collection
    get 'show_projects_of_users', on: :collection
    get 'view_user_project_details', on: :collection
  end
  
  root to: "dashboard#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
