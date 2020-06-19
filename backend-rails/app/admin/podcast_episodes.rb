ActiveAdmin.register PodcastEpisode do
  index do
    id_column
    column :title
    column :published
    actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
