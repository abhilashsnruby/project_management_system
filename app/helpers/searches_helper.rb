module SearchesHelper

  def retrive_data_for_pagination(action_name, index_value)
    projects_ids = Project.pluck(:id)
    users_ids = User.pluck(:id)
    employees_ids = Employee.pluck(:id)
    tasks_ids = Task.pluck(:id)

    if action_condition(projects_ids, users_ids, employees_ids, tasks_ids, index_value)
      table_values = []
      table_ids = assign_table_ids(action_name, projects_ids, users_ids, employees_ids, tasks_ids)
      table_data = retrive_table_values(action_name, table_ids)

      table_data.each do |data|
        table_values << data.attributes.values[0..2]
      end
      table_values
    else
      retrun_table_data(action_name)
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

  def retrive_table_values(action_name, table_ids)
    case "#{action_name}"
    when "Project"
      Project.where(id: table_ids[table_ids[3] .. Project.count])
    when "User"
      User.where(id: table_ids[table_ids[3] .. User.count])
    when "Employee"
      Employee.where(id: table_ids[table_ids[3] .. Employee.count])
    when "Task"
      Task.where(id: table_ids[table_ids[3] .. Task.count])
    end
  end
end