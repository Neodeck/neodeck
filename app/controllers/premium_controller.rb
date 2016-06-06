class PremiumController < ApplicationController
  skip_before_action :verify_authenticity_token # because stripe doesn't send authenticity token

  def buy
    @title = "Buy Premium"
  end

  def stripe
    validate_logged_in

    unless current_user.premium
      token = params[:stripeToken]

      begin
        charge = Stripe::Charge.create(
          :amount => current_user.premium_price,
          :currency => "usd",
          :source => token,
          :description => "CAH Creator Premium Account for #{current_user.email}",
          :metadata => {
            "user_id" => current_user.id
          }
        )

        current_user.update(:premium => true, :stripe_charge_id => charge["id"])

        render "premium/thanks"
      rescue Stripe::CardError => e
        render plain: "There was an error processing your card. Please go back and try again."
      end
    else
      redirect_to root_path
    end
  end
end
