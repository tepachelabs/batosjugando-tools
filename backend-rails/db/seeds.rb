if Rails.env.development?
  puts 'Adding Developments Seeds...'

  # Users
  AdminUser.create!(email: 'admin@otfusion.org', password: 'password', password_confirmation: 'password')

  # LastPublished
  LastPublished.create!(twitter_username: 'batosjugando')
end
