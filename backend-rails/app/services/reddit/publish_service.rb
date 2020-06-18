class Reddit::PublishService
  def initialize(oauth_service = nil, api_client = nil)
    @oauth_service = oauth_service || Reddit::OAuthService.new
    @api_client = api_client || Reddit::ApiClient.new
  end

  def call(reddit_token, podcast_episode)
    reddit_token = @oauth_service.refresh_authorization_token(reddit_token)
    @api_client.add_token(reddit_token.auth_token)

    send_to_videogames(podcast_episode)
    send_to_videojuegos(podcast_episode)
  end

  private

  def send_to_videojuegos(podcast_episode)
    options = {
      submit_title: "Podcast - #{podcast_episode.title}",
      submit_url: podcast_episode.url
    }
    response = @api_client.submit_link('videojuegos', options)

    podcast_episode.update(published: true) if response.code == 200
  end

  def send_to_videogames(podcast_episode)
    flair_list = @api_client.flair_list('videogames')
    flair_item = JSON.parse(flair_list).find { |e| e[:text] == 'Other' }
    flair_id = flair_item[:id]

    return if flair_id.nil?

    options = {
      submit_title: "Podcast - Español - #{podcast_episode.title}",
      submit_url: podcast_episode.url,
      flair_id: flair_id
    }

    response = @api_client.submit_link('videogames', options)

    podcast_episode.update(published: true) if response.code == 200
  end
end
