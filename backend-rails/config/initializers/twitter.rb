module BatosJugando
  def self.twitter?
    return Rails.application.credentials.twitter.present?
  end
end