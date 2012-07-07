# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    User.create([{ email: 'test@commonground.com'}])
    Room.create([{ name: 'test'}, {members: 0}])
    User.create([{ email: 'test2@commonground.com'}, {latitude: 100.0}, {longitude: 100.0}])
    User.create([{ email: 'test3@commonground.com'}, {latitude: 150.0}, {longitude: 150.0}])
