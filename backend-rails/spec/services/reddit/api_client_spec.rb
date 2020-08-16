describe Reddit::ApiClient do
  describe '#submit_link' do
    let(:reddit_response_body) { file_fixture('reddit/submit_link_response.json').read }
    let(:reddit_response) { instance_double(HTTParty::Response, body: reddit_response_body) }

    let(:body_subreddit) { 'bideogaems' }
    let(:body_url) { 'https://foo' }
    let(:body_title) { 'foo title' }
    let(:body_flair_id) { '1' }

    let(:request_body) do
      {
        sr: body_subreddit,
        url: body_url,
        title: body_title,
        kind: 'link',
        flair_id: body_flair_id,
        sendreplies: true
      }
    end

    let(:options) do
      { submit_url: body_url,
        submit_title: body_title,
        flair_id: body_flair_id }
    end

    subject do
      described_class.new
                     .submit_link(body_subreddit, options)
    end

    context 'when flair id is present' do
      it 'does successfully get called' do
        stub_request(:post, 'https://oauth.reddit.com/api/submit')
          .to_return(status: 200, body: '', headers: {})

        subject

        expect(a_request(:post, 'https://oauth.reddit.com/api/submit')
                   .with(body: request_body)).to have_been_made.once
      end
    end

    context 'when flair id is not present' do
      let(:options) do
        { submit_url: body_url,
          submit_title: body_title
        }
      end

      let(:request_body) do
        {
          sr: body_subreddit,
          url: body_url,
          title: body_title,
          kind: 'link',
          sendreplies: true
        }
      end

      it 'does successfully get called' do
        stub_request(:post, 'https://oauth.reddit.com/api/submit')
            .to_return(status: 200, body: '', headers: {})

        subject

        expect(a_request(:post, 'https://oauth.reddit.com/api/submit')
                   .with(body: request_body)).to have_been_made.once
      end
    end
  end
end
