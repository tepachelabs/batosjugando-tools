class Twitter::AccessTokenClient
  include HTTParty

  base_uri 'https://api.twitter.com'

  def initialize
    @headers = {
      'User-Agent': 'BatosJugando',
      'Content-Type': 'application/x-www-form-urlencoded'
    }
  end

  def access_token(token, verifier)
    response = self.class.post('/oauth/access_token', body: body(token, verifier))

    raise "#{self.class} => Received HTTP: #{response.code} -> #{response.message}" if response.code != 200

    the_hash = Hash.new do |hash, key|
      arr = key.split('=')
      hash[arr[0].to_sym] = arr[1]
    end

    response.parsed_response.split('&').each { |x| the_hash[x] }

    Struct.new(the_hash)
  end

  private

  def response_element(str)
    str.split('=')
  end

  def body(token, verifier)
    %W[oauth_token=#{token}
       oauth_verifier=#{verifier}]
      .join('&')
  end
end
