json.ignore_nil!

json.set! :participants do
  json.array! @participants,
              :name, :description, :avatar_url, :email,
              :favorite_game, :twitter_username, :twitch_username,
              :other_link
end
