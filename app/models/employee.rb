class Employee < ApplicationRecord
  has_one :user

  def self.retrive_complete_employee_details
    @employees = Employee.all
    @users = User.all
    [@employees, @users]
  end

  def self.retrive_employees_data(params)
    employee_ids = Employee.pluck(:id)
    if employee_ids.count > params['index'].to_i
      Employee.where(id: employee_ids[employee_ids[3] .. Employee.count])
    else
      Employee.all
    end
  end
end