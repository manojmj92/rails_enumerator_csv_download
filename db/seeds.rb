# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Seeding users
attributes = User.columns.map(&:name) - ["created_at", "updated_at", "id"]

(1..100000).each do |n|
  h = Hash[attributes.collect { |v| [v, Faker::Name.name] }]
  User.create!(h)
end
