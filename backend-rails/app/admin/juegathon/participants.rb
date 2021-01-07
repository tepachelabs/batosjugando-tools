ActiveAdmin.register Juegathon::Participant do
  menu parent: 'Juegathon', label: 'Participants'

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :avatar_url
      row :description
      row :email
      row :favorite_game
      row :twitter_username
      row :twitch_username
      row :other_link
      row :events do |m|
        m.events.map(&:name)
      end
      active_admin_comments
    end
  end

  form do |f|
    f.inputs 'Participant Details' do
      f.input :name
      f.input :avatar_url
      f.input :description
      f.input :email
      f.input :favorite_game
      f.input :twitter_username
      f.input :twitch_username
      f.input :other_link
      f.input :event_ids, as: :check_boxes, collection: Juegathon::Event.all.map { |e| [e.name, e.id] }
    end

    f.actions
  end

  filter :name
end
