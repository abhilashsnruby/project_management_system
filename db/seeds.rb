# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |num|
  Project.create(title: "project_#{num}", description: "#{num} deals with payroll", category_name: "social_#{num}")
end

5.times do |num|
  Task.create(task_name: "task_#{num}", project_id: num)
end

