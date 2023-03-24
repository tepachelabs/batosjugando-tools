FactoryBot.define do
  factory :rss_response, class: OpenStruct do
    title { Faker::Show.play }
    url { Faker::Internet.url }
    summary { Faker::Lorem.paragraph(sentence_count: 10) }
    enclosure_url { Faker::Internet.url(path: '/file.mp3') }
    season { Faker::Number.between(from: 1, to: 10) }
    episode { Faker::Number.between(from: 1, to: 10) }
    published { Faker::Date.between(from: DateTime.now - 10.days, to: DateTime.now) }
  end
end
