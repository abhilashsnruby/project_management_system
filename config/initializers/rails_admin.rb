RailsAdmin.config do |config|

  config.authorize_with do
    redirect_to main_app.root_path unless warden.user.roles.pluck(:name).include?('admin') == true
  end
  ### Popular gems integration

  config.model ProjectOwner do
    list do
      field :id do
        formatted_value do
          path = bindings[:view].show_path(model_name: 'ProjectOwner', id: bindings[:object].id)
          bindings[:view].link_to(bindings[:object].id, path)
        end
      end
      field :project_owner_name do
        formatted_value do
          bindings[:object].project_owner_name
        end
      end
      field :qualification do
        formatted_value do
          bindings[:object].qualification
        end
      end
      field :user_id do
        formatted_value do
          bindings[:object].qualification
        end
      end
      field :created_at do
        formatted_value do
          bindings[:object].created_at
        end
      end
      field :updated_at do
        formatted_value do
          bindings[:object].updated_at
        end
      end
    end
  end

  # config.model Utility do
  # configure :preview do
  #   pretty_value do
  #     util = bindings[:object]
  #     %{<div class="blah">
  #         #{util.name} #{util.phone} #{util.logo}
  #       </div >}
  #   end
  #   children_fields [:name, :phone, :logo] # will be used for searching/filtering, first field will be used for sorting
  #   read_only true # won't be editable in forms (alternatively, hide it in edit section)
  # end

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)
  config.current_user_method(&:current_user)
  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end