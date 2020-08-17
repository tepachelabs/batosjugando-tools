FactoryBot.define do
  factory :juegathon_participant, class: Juegathon::Participant do
    name { Faker::Name.name }
    avatar_url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    email { Faker::Internet.email }
    favorite_game { Faker::Game.title }
    twitter_username { Faker::Twitter.screen_name }
    twitch_username { Faker::Twitter.screen_name }
    other_link { Faker::Internet.url }
  end
end
