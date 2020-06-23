class Discord::WebhookClient
  include HTTParty

  def initialize(webhook_url)
    @webhook_url = webhook_url
  end

  def send_message(message)
    self.class.post(@webhook_url, body: body(message),
                       headers: { 'Content-Type' => 'application/json' })
  end

  private

  def body(content)
    { content: content }.to_json
  end
end
