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
Filament.create(description: "ABS White", hex_color_value: "0xAAAAAA", price_per_gram: "1", remaining: "1000")
Filament.create(description: "ABS Black", hex_color_value: "0x111111", price_per_gram: "1", remaining: "1000")
Filament.create(description: "PLA White", hex_color_value: "0xAAAAAA", price_per_gram: "1", remaining: "1000")
Filament.create(description: "PLA Black", hex_color_value: "0x111111", price_per_gram: "1", remaining: "1000")
Filament.create(description: "PLA Pink", hex_color_value: "0xC879CE", price_per_gram: "1", remaining: "1000")
Filament.create(description: "PLA Salmon", hex_color_value: "0xED8B9C", price_per_gram: "1", remaining: "1000")
Filament.create(description: "PLA Green", hex_color_value: "0x9FED9C", price_per_gram: "1", remaining: "1000")
Filament.create(description: "PLA Blue", hex_color_value: "0x5AEDE0", price_per_gram: "1", remaining: "1000")
Filament.create(description: "PLA Purple", hex_color_value: "0x8364BC", price_per_gram: "1", remaining: "1000")
Filament.create(description: "PLA Orange", hex_color_value: "0xd17947", price_per_gram: "1", remaining: "1000")
PrintSpeed.create(configuration: "normal")
PrintSpeed.create(configuration: "fast")
