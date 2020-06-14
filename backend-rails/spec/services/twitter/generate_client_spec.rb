describe Twitter::GenerateClient do
  describe '.call' do
    let(:twitter_value) { true }
    before do
      allow(BatosJugando).to receive(:twitter?).and_return(twitter_value)
    end

    context 'twitter credentials are present' do
      it 'creates the twitter client' do
        expect(Twitter::REST::Client).to receive(:new).and_return(double("twitter"))
        described_class.call
      end
    end

    context 'twitter credentials are NOT present' do
      let(:twitter_value) { false }
      it 'does not call the initialier of the client' do
        expect(Twitter::REST::Client).to_not receive(:new)
        described_class.call
      end
    end
  end
end