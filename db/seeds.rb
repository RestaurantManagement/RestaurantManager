# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "hieuvecto",
             email: "hieuvecto@gmail.com",
             password:              "123abc",
             password_confirmation: "123abc",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

Category.create!(content: "Food")
Category.create!(content: "Drink")

50.times do |n|
  name = "Food #{n}"
  MenuItem.create!(name: name,
                   price: n,
                   category_id: 1)
end

70.times do |n|
  name = "Drink #{n}"
  MenuItem.create!(name: name,
                   price: n,
                   category_id: 2)
end