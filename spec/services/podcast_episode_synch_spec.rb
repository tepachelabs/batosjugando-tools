describe PodcastEpisodeSynch do
  let(:rss_reader) { double }
  let(:rss_response) do
    build_list(:rss_response, 10)
  end

  before do
    allow(rss_reader).to receive(:call)
      .and_return(rss_response)
  end

  subject do
    described_class.new(rss_reader)
  end

  describe '.call' do
    context 'when there is episodes' do
      it 'calls the create method of PodcastEpisode for all the RSS reader response' do
        expect(PodcastEpisode).to receive(:create)
          .with(any_args)
          .exactly(rss_response.count)
          .times

        subject.call
      end

      it 'calls the create method of PodcastEpisode for all the RSS reader response' do
        subject.call

        rss_response.reverse.each_with_index do |each_response, index|
          expect(PodcastEpisode.all[index].title).to be_eql(each_response.title)
          expect(PodcastEpisode.all[index].description).to be_eql(each_response.summary)
          expect(PodcastEpisode.all[index].audio_url).to be_eql(each_response.enclosure_url)
          expect(PodcastEpisode.all[index].season).to be_eql(each_response.itunes_season)
          expect(PodcastEpisode.all[index].episode).to be_eql(each_response.itunes_episode)
        end
      end
    end

    context 'when there is no episodes' do
      let(:rss_response) { [] }

      it 'does not call the create method' do
        expect(PodcastEpisode).to_not receive(:create)

        subject.call
      end
    end
  end
end
