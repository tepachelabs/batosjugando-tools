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

  filter :name
end
