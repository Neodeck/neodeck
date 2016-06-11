class SocketApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :verify_application

  def verify_application
    unless SocketApiApplication.where(:token => params[:token], :secret => params[:secret]).exists?
      render json: {
        error: 401
      }
    else
      application = SocketApiApplication.where(:token => params[:token], :secret => params[:secret]).first
    end
  end

  def user_with_token
    user = User.where(:socket_auth_token => params[:socket_token])
    if user.exists?
      render json: user.first.api_safe
    else
      render json: {
        error: 404
      }
    end
  end

  def save_deck
    begin
      deck = Deck.find(params[:deck_id])
      new_deck = params[:new_deck]

      # validate some stuff...
      if new_deck[:black_cards]
        unless deck.user.premium then new_deck[:black_cards] = new_deck[:black_cards][0..49] end
        black_cards = Deck.validate_black_cards(new_deck[:black_cards])
      else
        black_cards = []
      end

      if new_deck[:white_cards]
        unless deck.user.premium then new_deck[:black_cards] = new_deck[:black_cards][0..99] end
        white_cards = Deck.validate_white_cards(new_deck[:white_cards])
      else
        white_cards = []
      end

      deck.update(:name => new_deck[:name], :black_cards => black_cards, :white_cards => white_cards, :watermark => new_deck[:watermark])
      render json: { success: true }
    rescue
      render json: { success: false }
    end
  end

  def has_access_to_deck
    user = User.where(:socket_auth_token => params[:socket_token]).first
    deck = Deck.find(params[:deck_id])
    if user && deck
      if deck.user == user
        render json: {
          user: user.api_safe,
          deck: deck.api_safe,
          has_access: true
        }
      else
        render json: {
          user: user.api_safe,
          deck: deck.api_safe,
          has_access: false
        }
      end
    else
      render json: {
        error: 404
      }
    end
  end
end
