# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create example user
User.create!(name:                  "Example User",
             email:                 "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:                 true,
             activated:             true,
             activated_at:          Time.zone.now)

# create 99 more of them using Faker and some default values
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:                  name,
               email:                 email,
               password:              password,
               password_confirmation: password,
               activated:             true,
               activated_at:          Time.zone.now)
end

# Take first six seeded users in the order they were created
users = User.order(:created_at).take(6)
# give them each 50 seed posts, alternating the creating in such a
# way that the timestamps will load alternating users in the main feed,
# NOT 50 posts from one user followed by 50 from another and so on...
50.times do
  # user Faker gem's lorem ipsum generator
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
