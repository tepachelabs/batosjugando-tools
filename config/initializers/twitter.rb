module BatosJugando
  def self.twitter?
    Rails.application.credentials.twitter.present?
  end
end
