desc 'Read Episodes from Anchor RSS.'
task read_podcast_episodes: :environment do
  progressbar = ProgressBar.create(title: 'Fetching RSS', total: 1)
  xml = HTTParty.get(ENV.fetch('EL_HONGO_VERDE_RSS', nil)).body
  progressbar.increment

  progressbar = ProgressBar.create(title: 'Parsing RSS', total: 1)
  rss = Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
  progressbar.increment

  progressbar = ProgressBar.create(title: 'Reading RSS', total: rss.entries.count)
  episodes = []

  # fetch all episodes
  rss.entries.reverse_each do |item|
    # since this reads the itunes feed correctly... sigh
    episode = PodcastEpisode.find_or_create_by(url: item.url)
    episode.title = item.title
    episode.description = item.summary
    episode.season = item.itunes_season
    episode.episode = item.itunes_episode
    episode.audio_url = item.enclosure_url
    episodes << episode
    progressbar
  end

  progressbar = ProgressBar.create(title: 'Storing episodes', total: 1)
  PodcastEpisode.transaction do
    episodes.each(&:save)
  end
  progressbar.increment
end
