RailsAdmin.config do |config|
  require 'i18n'
  I18n.default_locale = :en
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
      field :stripe_charge_id do |field|
        help "Charge ID that Stripe sent if this user bought Premium."
      end
      include_all_fields
      exclude_fields :password_digest, :custom_badges
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

  config.model 'DeckOrder' do
    list do
      field :id
      field :shipped
      field :tracking_number
      field :user
      field :stripe_charge_id
    end

    edit do
      field :shipping_name
      field :shipping_line_1
      field :shipping_line_2
      field :shipping_city
      field :shipping_state
      field :shipping_country
      field :shipping_zip
      field :cancelled
      include_all_fields
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
