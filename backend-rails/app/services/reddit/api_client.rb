class Reddit::ApiClient < Reddit::BaseClient
  # Reddit API
  # https://www.reddit.com/dev/api/
  base_uri 'https://oauth.reddit.com'

  def initialize(auth_token = nil)
    super()
    add_token(auth_token)
  end

  def add_token(auth_token = nil)
    @headers['Authorization'] = "bearer #{auth_token}" if auth_token.present?
  end

  def submit_link(subreddit, options = {})
    response = self.class.post('/api/submit',
                               body: submit_link_body(subreddit, options),
                               headers: @headers)

    process(response)
  end

  def flair_list(subreddit)
    response = self.class.get("/r/#{subreddit}/api/link_flair_v2",
                              headers: @headers)

    process(response)
  end

  private

  def submit_link_body(subreddit, options = {})
    body = %W[sr=#{subreddit}
              url=#{options[:submit_url]}
              title=#{options[:submit_title]}
              kind=link
              sendreplies=true]

    body < "flair_id:#{options[:flair_id]}" if options[:flair_id].present?

    body.join('&')
  end
end
