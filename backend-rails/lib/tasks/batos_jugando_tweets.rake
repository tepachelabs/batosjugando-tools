desc "Read Tweets from Batos Jugando and seek for #discord hashtag"
task :batos_jugando_tweets => :environment do
  DiscordToTwitterWorker.perform_async
end