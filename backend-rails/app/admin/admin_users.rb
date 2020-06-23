ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column 'Reddit Token' do |admin|
      admin.reddit_token.present?
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

    panel('Reddit Token') do
      if admin.reddit_token.present?
        attributes_table_for admin.reddit_token do
          row :id
          row :auth_token
          row :refresh_token
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
