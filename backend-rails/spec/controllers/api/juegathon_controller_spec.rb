describe Api::JuegathonController do
  context '#participants' do
    let!(:participant) { create(:juegathon_participant) }

    let(:response_keys) do
      %w[participants]
    end

    let(:participant_keys) do
      %w[avatar_url description email favorite_game name other_link twitch_username
         twitter_username participations]
    end

    subject { get :participants, format: :json }

    it 'returns a successful json answer' do
      subject
      expect(response.status).to be 200
      parsed_body = JSON.parse(response.body)

      expect(parsed_body.keys).to match_array(response_keys)
      expect(parsed_body['participants']).to be_a Enumerable
      expect(parsed_body['participants'].first.keys).to match_array(participant_keys)
    end
  end
end
