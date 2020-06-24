class Reddit::BaseClient
  include HTTParty
  include Reddit::Credentials

  def initialize
    @headers = {
      'User-Agent': 'BatosJugando',
      'Content-Type': 'application/x-www-form-urlencoded'
    }
  end

  private

  def process(response)
    raise "#{self.class} => Received HTTP: #{response.code} -> #{response.message}" if response.code != 200

    response
  end
end
