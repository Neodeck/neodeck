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

  def edit
    @deck = Deck.find(params[:id])
    @title = "Editing #{@deck.name}"
    unless @deck && current_user == @deck.user
      redirect_to root_path
    end
  end
end
