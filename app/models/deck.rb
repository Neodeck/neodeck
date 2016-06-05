class Deck < ActiveRecord::Base
  serialize :black_cards
  serialize :white_cards
  belongs_to :user
  before_create :initialize_cards

  def initialize_cards
    self.black_cards ||= []
    self.white_cards ||= []
  end

  def self.validate_black_cards(cards)
    validated_cards = []

    cards.each do |card|
      if card[:text] && card[:text].length > 0 && card[:pick] && card[:pick] > 0
        validated_cards.push({
          text: card[:text],
          pick: card[:pick]
        })
      end
    end

    validated_cards
  end

  def self.validate_white_cards(cards)
    validated_cards = []

    cards.each do |card|
      if card && card.length > 0
        validated_cards.push(card)
      end
    end

    validated_cards
  end

  def api_safe
    {
      id: self.id,
      name: self.name,
      description: self.description,
      owner_id: self.user.id,
      black_cards: self.black_cards,
      white_cards: self.white_cards
    }
  end

  def to_cae_readable
    {
      id: self.id,
      name: self.name,
      description: "Created with cahcreator.com",
      expansion: true,
      blackCards: self.black_cards,
      whiteCards: self.white_cards
    }
  end
end
