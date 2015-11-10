require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

500.times do
cd = Cd.create!(
    bankname: Faker::Name.name,
    old_rate: Faker::Number.between(1.00, 3.00),
    principal: Faker::Number.between(99000, 250000),
    maturity_date: Faker::Date.forward(1460),
    old_ewp: Faker::Number.between(90, 180),
    old_fee: (Faker::Number.between(1.1, 1.2) - 1),

  )
end

admin = User.new(
   name:     'Admin',
   email:    'admin@example.com',
   password: 'helloworld',
   role:     'admin'
 )
 admin.skip_confirmation!
 admin.save!

puts "Seed finished"

puts "#{Cd.count} cds created"
