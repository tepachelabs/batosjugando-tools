class Reddit::PublishService < Publish::BaseService
  def initialize(oauth_service = nil, api_client = nil)
    @oauth_service = oauth_service || Reddit::OAuthService.new
    @api_client = api_client || Reddit::ApiClient.new
  end

  def publish(user, publish_job)
    reddit_token = user.reddit_token
    return unless @oauth_service.refresh_authorization_token(reddit_token)

    @api_client.add_token(reddit_token.auth_token)

    # hardcoded meh
    if Rails.env.development?
      send_to_subreddit('otfusion', publish_job)
    else
      send_to_subreddit('videojuegos', publish_job)
      send_to_videogames(episode)
    end
  end

  private

  def send_to_subreddit(subreddit, publish_job)
    podcast_episode = publish_job.podcast_episode
    options = {
      submit_title: "Podcast - #{podcast_episode.title}",
      submit_url: podcast_episode.url
    }

    response = @api_client.submit_link(subreddit, options)

    publish_job.update(status: "published") if response.code == 200
  end

  def send_to_videogames(publish_job)
    podcast_episode = publish_job.podcast_episode
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

    publish_job.update(status: "published") if response.code == 200
  end
end
