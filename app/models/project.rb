class Project < ApplicationRecord
  resourcify
  require 'csv'

  has_many :tasks, dependent: :destroy
  belongs_to :user
  belongs_to :project_owner

  def self.assign_tasks_to_project(params) 
    tasks, priorities, deadlines, status = Task.find_task_details(params)
    Task.save_task_priority_details(tasks, priorities, params)
    Task.save_task_deadlines_details(tasks, deadlines, params)
    Task.save_task_status_details(tasks, status, params)
  end

  def self.assign_projects_to_users(params)
    user_projects = params['user_projects']['project'][0].values
    user_id = User.find_by_user_name(params['user_name']).id
    projects = Project.where(title: user_projects)
    projects.each do |project|
      project.update_attributes(user_id: user_id)
    end
    projects
  end

   # Generate a CSV File of All Project Records
   def self.to_csv(fields = column_names, options={})
     user_columns = ["user_name", "email", "employee_id"]

     CSV.generate(options) do |csv|
       csv << fields
       all.each do |project|
         project_values = project.attributes.values_at(*fields)
         user_values = []
         user_name = project.user.attributes['user_name']
         email = project.user.attributes['email']
         employee_id = project.user.attributes['employee_id']
         user_values << user_name
         user_values << email
         user_values << employee_id
         csv << project_values.compact + user_values
       end
     end
   end
   # Import CSV, Find or Create Project by its title.
   # Update the record.
   def self.import(file)
     filename = File.join Rails.root, file
     user_counter = 0
     project_counter = 0
     CSV.foreach(filename, headers: true) do |row|
       projects_hash = row.to_hash
       if Project.where(title: projects_hash['title']).present?
         project = Project.find_or_create_by!(title: projects_hash['title'])
       else
         projects_hash = projects_hash.delete_if { |k,v| ['user_name', 'email', 'employee_id'].include? k }
         project = Project.create!(projects_hash)
       end
       if User.where(user_name: projects_hash['user_name']).present?
         user = User.find_or_create_by!(user_name: projects_hash['user_name'])
       else
         users_hash = projects_hash.slice('user_name', 'email', 'password', 'password_confirmation', 'employee_id')
         project = User.create!(users_hash)
       end
       users_hash = projects_hash.slice('user_name', 'email', 'password', 'password_confirmation', 'employee_id')
       projects_hash = projects_hash.delete_if { |k,v| ['user_name', 'email', 'password', 'password_confirmation', 'employee_id'].include? k }
       user.update_attributes(users_hash)
       project.update_attributes(projects_hash)
       puts "#{users_hash[:email]} - #{user.errors.full_messages.join(",")}" if user.errors.any?
       puts "#{projects_hash[:title]} - #{user.errors.full_messages.join(",")}" if project.errors.any?
       user_counter += 1 if user.persisted?
       project_counter += 1 if project.persisted?
     end
     puts "Imported #{user_counter} users"
     puts "Imported #{project_counter} users"
   end

  # def self.prgrub
  #   binding.pry
  #   a = [12,21,12,1]
  #   numbers = []
  #   a.each_with_index do |num, index|
  #     binding.pry
  #     if (a[index] > a[index + 1])
  #       numbers << a[index + 1]
  #     else
  #       numbers << a[index]
  #     end
  #   end
  # end

end