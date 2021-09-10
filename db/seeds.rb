# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email: "info@bonarinstitute.com", password: "1123581321")

10.times do
    Associate.create(name: Faker::Name.unique.name, emailaddress: Faker::Internet.email)
end

10.times do
    Client.create(name: Faker::Name.unique.name, emailaddress: Faker::Internet.email)
end