class DeckOrdersController < ApplicationController
  before_filter :validate_logged_in
  skip_before_action :verify_authenticity_token

  def show
    @order = DeckOrder.find(params[:id])
    unless @order.user == current_user then redirect_to root_path end
    @title = "Order \##{@order.id}"
  end

  def new
    @deck = Deck.find(params[:deck])
    @title = "Order Deck"

    if current_user.stripe_customer_id
      @customer = current_user.stripe_customer
    end
  end

  def quote
    @deck = Deck.find(params[:address][:deck_id])
    unless @deck.user == current_user then redirect_to root_path end
    @title = "Order Deck"

    shipping = DeckOrder.calculate_shipping({
      :country => params[:address][:country],
      :state => params[:address][:state],
      :city => params[:address][:city],
      :zip => params[:address][:zip]
    })

    @quote = {
      :deck_price => '%.2f' % @deck.price,
      :shipping_price => '%.2f' % shipping[1],
      :shipping_service => shipping[0],
      :total_price => '%.2f' % (@deck.price + shipping[1]),
      :total_price_cents => ((@deck.price + shipping[1]) * 100).to_i,
      :city => "#{params[:address][:city]}, #{params[:address][:state]}, #{params[:address][:country]}",
      :shipping_name => params[:address][:name],
      :shipping_zip => params[:address][:zip],
      :shipping_line1 => params[:address][:line1],
      :shipping_line2 => params[:address][:line2],
      :address => params[:address]
    }

    render "new"
  end

  def order
    deck = Deck.find(params[:order][:deck_id])
    unless deck.user == current_user then redirect_to root_path end

    # re-calculate everything to make sure the client isn't lying to us
    shipping = DeckOrder.calculate_shipping({
      :country => params[:order][:address_country],
      :state => params[:order][:address_state],
      :city => params[:order][:address_city],
      :zip => params[:order][:address_zip]
    })

    total_price = ((shipping[1] + deck.price) * 100).to_i

    token = params[:stripeToken]

    unless current_user.stripe_customer
      customer = Stripe::Customer.create(
        :description => current_user.name,
        :email => current_user.email,
        :metadata => {
          :user_id => current_user.id
        },
        :source => token,
        :shipping => {
          :name => params[:order][:address_name],
          :address => {
            :line1 => params[:order][:address_line1],
            :line2 => params[:order][:address_line2],
            :country => params[:order][:address_country],
            :state => params[:order][:address_state],
            :city => params[:order][:address_city],
            :postal_code => params[:order][:address_zip]
          }
        }
      )

      current_user.update(:stripe_customer_id => customer["id"])
    else
      customer = current_user.stripe_customer
    end

    begin
      charge = Stripe::Charge.create(
        :amount => total_price,
        :currency => "usd",
        :customer => customer["id"],
        :receipt_email => current_user.email,
        :description => "Custom Deck Print for #{current_user.email}",
        :metadata => {
          :user_id => current_user.id
        }
      )

      order = DeckOrder.create({
        :deck => deck,
        :user => current_user,
        :shipping_name => params[:order][:address_name],
        :shipping_line_1 => params[:order][:address_line1],
        :shipping_line_2 => params[:order][:address_line2],
        :shipping_country => params[:order][:address_country],
        :shipping_city => params[:order][:address_city],
        :shipping_state => params[:order][:address_state],
        :shipping_zip => params[:order][:address_zip],
        :base_price => deck.price,
        :shipping_price => shipping[1],
        :stripe_charge_id => charge["id"]
      })

      charge = Stripe::Charge.retrieve(charge["id"])
      charge.metadata = {
        :user_id => current_user.id,
        :order_id => order.id
      }
      charge.save

      redirect_to order
    rescue Stripe::CardError => e
      render plain: "There was an error processing your card. Please go back and try again."
    end
  end
end
