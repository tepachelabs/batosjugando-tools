ActiveAdmin.register Juegathon::Event do
  menu parent: 'Juegathon', label: 'Events'

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :start_datetime
    column :end_datetime
    column :total_donation
    actions
  end

  filter :name
end
