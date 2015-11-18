require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin = User.new(
   name:     'Admin',
   email:    'admin@jumbocd.com',
   password: 'mike7365',
   role:     'admin'
 )
 admin.skip_confirmation!
 admin.save!

puts "Seed finished"

puts "#{User.count} users created"
