json.extract! task, :id, :task_name, :project_id, :created_at, :updated_at
json.url task_url(task, format: :json)
