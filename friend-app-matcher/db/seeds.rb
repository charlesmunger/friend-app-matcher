# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "primaryuser@test.com",
            password: "password",
            password_confirmation: "password",
            uid: "x1010101010",
            remember_me: false,
            provider: "facebook",
            username: "primaryuser",
            name: "primaryuser")
