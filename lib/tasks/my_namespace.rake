namespace :my_namespace do
  desc "TODO"
  task my_task1: :environment do
    array = ['abhilash','bahubali',
             'himesh','indira',
             'lavika','anil',
             'shobha','himanshu']

    array.each_with_index do |employee, index|
      if (index == array.count - 1)
        Employee.create(empname: employee,
                        first_name: employee,
                        middle_name: employee[0...4],
                        second_name: employee.chars.last(3).join)
      else
        Employee.create(empname: employee,
                        first_name: employee,
                        middle_name: array[index+1],
                        second_name: employee.chars.last(3).join)
      end
    end
  end
end
