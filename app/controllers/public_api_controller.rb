class PublicApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def deck
    deck = Deck.find(params[:id])
    if deck
      render json: deck.to_cae_readable
    else
      render json: { error: "Deck not found" }
    end
  end
end
