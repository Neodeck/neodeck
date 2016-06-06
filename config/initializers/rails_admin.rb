RailsAdmin.config do |config|
  config.authorize_with do
    redirect_to main_app.root_path unless current_user && current_user.admin
  end

  config.model 'User' do
    list do
      field :id
      field :name
      field :email
      field :admin
      field :premium
      field :stripe_charge_id
    end

    edit do
      field :name
      field :email
      field :admin
      field :premium
      include_all_fields
      exclude_fields :password_digest
    end
  end

  config.model 'Deck' do
    list do
      field :id
      field :name
      field :description
      field :user
    end

    edit do
      include_all_fields
      exclude_fields :white_cards, :black_cards
    end
  end

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
  end
end
