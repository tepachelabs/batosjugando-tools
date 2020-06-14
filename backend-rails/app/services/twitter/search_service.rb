class Twitter::SearchService
  def initialize(client = Twitter::GenerateClient.call)
    @client = client
  end

  def call
    batos_jugando_reads = ReadTweet.find_by(username: 'batosjugando')
    tweets = @client.search(query, since_id: batos_jugando_reads.last_tweet_id.to_i)

    desc_tweets = []

    tweets.reverse_each do |tweet|
      desc_tweets << {
          tweet_id: tweet.id,
          text: tweet.text
      }
    end

    desc_tweets
  end

  private

  def query
    "(#discord) (from:batosjugando)"
  end

end