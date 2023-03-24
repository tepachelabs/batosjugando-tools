ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column 'Publish Configuration' do |admin|
      admin.publish_configuration.present?
    end
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do |admin|
    attributes_table do
      row :email
      row :created_at
      row :updated_at
    end

    panel('Publish Configuration') do
      if admin.publish_configuration.present?
        attributes_table_for admin.publish_configuration do
          row :id
          row :reddit_token
          row :reddit_refresh_token
          row :twitter_oauth_token
          row :twitter_oauth_token_secret
        end
      else
        div class: 'blank_slate_container', id: 'dashboard_default_message' do
          span class: 'blank_slate' do
            span I18n.t('active_admin.reddit_token.empty_row_header')
            small I18n.t('active_admin.reddit_token.empty_row_body')
          end
        end
      end
    end
  end
end
