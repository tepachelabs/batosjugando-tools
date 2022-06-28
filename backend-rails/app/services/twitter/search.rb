class Twitter::Search
  def initialize(client = nil)
    @client = client || Twitter::GenerateClient.call
  end

  def call(last_published = nil)
    tweets = @client.search(query, since_id: last_published&.last_tweet_id.to_i)

    desc_tweets = []

    tweets.reverse_each do |tweet|
      desc_tweets << OpenStruct.new(tweet_id: tweet.id, text: tweet.text, tweet_url: tweet.url.to_s)
    end

    desc_tweets
  end

  private

  def query
    '(#discord) (from:batosjugando)'
  end
end
