describe Twitter::SearchService do
  fixtures :last_published
  let(:twitter_client) { double('twitter_client') }
  describe '#call' do
    subject do
      Twitter::SearchService.new(twitter_client)
    end

    let(:tweet_1) { OpenStruct.new(id: 9_817_238_193_121, text: 'sample text for 1', url: 'https://localhost/1') }
    let(:tweet_2) { OpenStruct.new(id: 9_817_238_193_122, text: 'sample text for 2', url: 'https://localhost/2') }
    let(:tweet_3) { OpenStruct.new(id: 9_817_238_193_123, text: 'sample text for 3', url: 'https://localhost/3') }

    before do
      allow(twitter_client).to receive(:search)
        .and_return([tweet_1, tweet_2, tweet_3])
    end

    it 'returns the tweets correctly' do
      result = subject.call(LastPublished.find_by(twitter_username: 'batosjugando'))
      expect(result.count).to be 3
      expect(result[0].text).to eql 'sample text for 3'
      expect(result[0].tweet_url).to eql 'https://localhost/3'
      expect(result[0].tweet_id).to eq 9_817_238_193_123
      expect(result[1].text).to eql 'sample text for 2'
      expect(result[1].tweet_url).to eql 'https://localhost/2'
      expect(result[1].tweet_id).to eq 9_817_238_193_122
      expect(result[2].text).to eql 'sample text for 1'
      expect(result[2].tweet_url).to eql 'https://localhost/1'
      expect(result[2].tweet_id).to eq 9_817_238_193_121
    end
  end
end
