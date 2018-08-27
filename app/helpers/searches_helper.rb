module SearchesHelper

  def retrive_data_for_pagination(action_name, index_value, table_data_conditon)
    table_ids_array = []
    table_ids_array = all_table_ids

    if action_condition(table_ids_array[0], table_ids_array[1], table_ids_array[2], 
                        table_ids_array[3], index_value[4])
      table_ids = assign_table_ids(action_name, table_ids_array[0], table_ids_array[1], 
                                   table_ids_array[2], table_ids_array[3])
      table_data = retrive_table_values(action_name, table_ids, 
                                        table_data_conditon)
      retrive_final_data(action_name, table_data)
    else
      retrun_table_data(action_name)
    end
  end

  def all_table_ids
    projects_ids = Project.pluck(:id)
    users_ids = User.pluck(:id)
    employees_ids = Employee.pluck(:id)
    tasks_ids = Task.pluck(:id)

    [projects_ids, users_ids, employees_ids, tasks_ids]
  end

  def project_table_data(table_data)
    table_values = []
    data = table_data.pluck(:title,
                     :description,
                     :category_name)
    
    data.each_with_index do |data, index|
      table_values << [ "#{data[0]}",
                         "#{data[1]}",
                         "#{data[2]}" ]
    end
    table_values
  end

  def task_table_data(table_data)
    table_values = []
    task_data = []
    table_data.each do |task|
      task_data << [ task.task_name,
                     Project.find(task.project_id).title ]
    end

    task_data.each_with_index do |data, index|
      table_values << [ "#{data[0]}",
                        "#{data[1]}" ]
    end
    table_values
  end

  def employee_table_data(table_data)
    table_values = []
    data = table_data.pluck(:empname,
                     :first_name,
                     :second_name,
                     :middle_name)

    data.each_with_index do |data, index|
      table_values << [ "#{data[0]}",
                        "#{data[1]}",
                        "#{data[2]}",
                        "#{data[3]}" ]
    end
    table_values
  end

  def user_table_data(table_data)
    table_values = []
    user_data = []
    table_data.each do |user|
      user_data << [ user.user_name,
                     user.email,
                     Employee.find(user.employee_id).empname ]
    end

    user_data.each_with_index do |data, index|
      table_values << [ "#{data[0]}",
                        "#{data[1]}" ]
    end
    table_values
  end

  def retrive_final_data(action_name, table_data)
    case "#{action_name}"
    when "Project"
      project_table_data(table_data)
    when "User"
      user_table_data(table_data)
    when "Employee"
      employee_table_data(table_data)
    when "Task"
      task_table_data(table_data)
    end
  end

  def assign_table_ids(action_name, projects_ids, users_ids, employees_ids, tasks_ids)
    case "#{action_name}"
    when "Project"
      projects_ids
    when "User"
      users_ids
    when "Employee"
      employees_ids
    when "Task"
      tasks_ids
    end
  end

  def action_condition(projects_ids, users_ids, employees_ids, tasks_ids, index_value)
    (projects_ids.count > index_value ||
     users_ids.count > index_value ||
     employees_ids > index_value ||
     tasks_ids.count > index_value )
  end

  def retrun_table_data(action_name)
    case "#{action_name}"
    when "Project"
      Project.all
    when "User"
      User.all
    when "Employee"
      Employee.all
    when "Task"
      Task.all
    end
  end

  def remaining_table_value_count
    final_data = []
    table_ids_array = []
    table_ids_array = all_table_ids

    project_count = Project.where(id: table_ids_array[0][4 .. Project.last.id]).count
    user_count = User.where(id: table_ids_array[1][4 .. User.last.id]).count
    employee_count = Employee.where(id: table_ids_array[2][4 .. Employee.last.id]).count
    task_count = Task.where(id: table_ids_array[3][4 .. Task.last.id]).count
    final_data << [project_count, user_count, employee_count, task_count]
    final_data.flatten
    final_data
  end

  def project_previous_next_table_detail(table_ids, table_data_conditon)
    data = (table_data_conditon == 'previous') ?
            Project.where(id: table_ids[0 .. 3])
            : Project.where(id: table_ids[4 .. Project.last.id])
    data
  end

  def user_previous_next_table_detail(table_ids, table_data_conditon)
    data = (table_data_conditon == 'previous') ?
            User.where(id: table_ids[0 .. 3])
            : User.where(id: table_ids[4 .. User.last.id])
    data
  end

  def employee_previous_next_table_detail(table_ids, table_data_conditon)
    data = (table_data_conditon == 'previous') ?
            Employee.where(id: table_ids[0 .. 3])
            : Employee.where(id: table_ids[4 .. Employee.last.id])
    data
  end

  def task_previous_next_table_detail(table_ids, table_data_conditon)
    data = (table_data_conditon == 'previous') ?
            Task.where(id: table_ids[0 .. 3])
            : Task.where(id: table_ids[4 .. Task.last.id])
    data
  end

  def retrive_table_values(action_name, table_ids, table_data_conditon)
    case "#{action_name}"
    when "Project"
      project_previous_next_table_detail(table_ids, table_data_conditon)
    when "User"
      user_previous_next_table_detail(table_ids, table_data_conditon)
    when "Employee"
      employee_previous_next_table_detail(table_ids, table_data_conditon)
    when "Task"
      task_previous_next_table_detail(table_ids, table_data_conditon)
    end
  end
end