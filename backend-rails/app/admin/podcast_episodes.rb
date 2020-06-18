ActiveAdmin.register PodcastEpisode do
  index do
    id_column
    column :title
    column :published
    actions
  end
end
