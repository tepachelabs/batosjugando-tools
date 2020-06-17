# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  puts 'Adding Developments Seeds...'

  # Users
  admin = AdminUser.create!(email: 'admin@otfusion.org', password: 'password', password_confirmation: 'password')

  # Reddit
  RedditToken.create!(admin_user_id: admin.id)

  # Twitter
  ReadTweet.create!(username: 'batosjugando')
end
