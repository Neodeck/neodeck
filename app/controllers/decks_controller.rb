class DecksController < ApplicationController
  def create
    new_deck = Deck.create(:name => params[:deck][:name], :user => current_user)
    if new_deck
      redirect_to edit_deck_path(new_deck)
    else
      flash[:error] = "FUCK"
      redirect_to new_deck_path
    end
  end

  def new
    validate_logged_in
    @title = "New Deck"
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def import
    validate_logged_in
    @title = "Import Deck"
  end

  def import_deck
    validate_logged_in
    imported_deck = JSON.parse(params[:imported_deck][:json], :symbolize_names => true)
    black_cards = Deck.validate_black_cards(imported_deck[:blackCards])
    white_cards = Deck.validate_white_cards(imported_deck[:whiteCards])
    deck = Deck.create(:name => imported_deck[:name], :black_cards => black_cards, :white_cards => white_cards, :user => current_user)
    redirect_to edit_deck_path(deck)
  end

  def edit
    @deck = Deck.find(params[:id])
    @title = "Editing #{@deck.name}"
    unless @deck && current_user == @deck.user
      redirect_to root_path
    end
  end
end
