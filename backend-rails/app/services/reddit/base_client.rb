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
    capture_error(response) if response.code != 200
    response
  end

  def capture_error(response)
    Raven.capture_message("#{self.class} => Received HTTP: #{response.code} -> #{response.message}")
  end
end
