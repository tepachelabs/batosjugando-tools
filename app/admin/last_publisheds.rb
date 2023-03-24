ActiveAdmin.register LastPublished do
  menu parent: 'Publish', label: 'Last Published'

  index do
    id_column
    column :name
    column :twitter_username
    column :last_tweet_id
    column :podcast_episode_url
    actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
