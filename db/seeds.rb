# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
UserGroup.create(group_name: "admin")
UserGroup.create(group_name: "staff")
UserGroup.create(group_name: "customer")
admin_group = UserGroup.find_by group_name: "admin"
staff_group = UserGroup.find_by group_name: "staff"
User.create(email: "admin@admin.admin", username: "admin", password: "admin", user_group_id: admin_group.id)
User.create(email: "staff@staff.staff", username: "staff", password: "staff", user_group_id: staff_group.id)
