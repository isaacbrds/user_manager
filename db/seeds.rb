# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
User.create(full_name: 'Admin', email: 'admin@mail.com', password: '123456', password_confirmation: '123456', role: 'admin')

p 'User successful created!'

10.times do 
    User.create(full_name: Faker::Name.name, email: Faker::Internet.email, password: '123456', password_confirmation: '123456', role: ['admin', 'client'].sample)
end
p 'Users successful created!'