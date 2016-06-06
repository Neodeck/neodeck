class DecksController < ApplicationController
  def create
    if current_user.decks.length >= current_user.deck_limit
      flash[:error] = "Deck limit reached! To raise this limit, please purchase a Premium account."
      redirect_to premium_path
    else
      new_deck = Deck.create(:name => params[:deck][:name], :user => current_user)
      if new_deck
        redirect_to edit_deck_path(new_deck)
      else
        flash[:error] = "FUCK"
        redirect_to new_deck_path
      end
    end
  end

  def new
    validate_logged_in
    if current_user.decks.length >= current_user.deck_limit
      flash[:error] = "Deck limit reached! To raise this limit, please purchase a Premium account."
      redirect_to premium_path
    else
      @title = "New Deck"
    end
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def import
    validate_logged_in
    if current_user.decks.length >= current_user.deck_limit
      flash[:error] = "Deck limit reached! To raise this limit, please purchase a Premium account."
      redirect_to premium_path
    else
      @title = "Import Deck"
    end
  end

  def select
    validate_logged_in
    @title = "Select Deck"
    @user = current_user
  end

  def import_deck
    validate_logged_in
    if current_user.decks.length >= current_user.deck_limit
      flash[:error] = "Deck limit reached! To raise this limit, please purchase a Premium account."
      redirect_to premium_path
    else
      imported_deck = JSON.parse(params[:imported_deck][:json], :symbolize_names => true)
      black_cards = Deck.validate_black_cards(imported_deck[:blackCards])
      white_cards = Deck.validate_white_cards(imported_deck[:whiteCards])
      deck = Deck.create(:name => imported_deck[:name], :black_cards => black_cards, :white_cards => white_cards, :user => current_user)
      redirect_to edit_deck_path(deck)
    end
  end

  def edit
    @deck = Deck.find(params[:id])
    @title = "Editing #{@deck.name}"
    unless @deck && current_user == @deck.user || current_user.admin
      redirect_to root_path
    end
  end
end
