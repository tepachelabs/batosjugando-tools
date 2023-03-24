json.ignore_nil!

json.set! :participants do
  json.array! @participants do |participant|
    json.name participant.name
    json.description participant.description
    json.avatar_url participant.avatar_url
    json.email participant.email
    json.favorite_game participant.favorite_game
    json.twitter_username participant.twitter_username
    json.twitch_username participant.twitch_username
    json.other_link participant.other_link

    participations = []
    participant.participations.each do |p|
      participations << @events[p.juegathon_events_id]
    end

    json.participations(participations)
  end
end
