ActiveAdmin.register PublishConfiguration do
  index do
    selectable_column
    id_column
    column :admin_user
    actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
