class Deck < ActiveRecord::Base
  serialize :black_cards
  serialize :white_cards
  validates_length_of :watermark, :maximum => 12
  belongs_to :user
  before_create :initialize_cards

  def initialize_cards
    self.black_cards ||= []
    self.white_cards ||= []
  end

  def total_cards
    self.black_cards.count + self.white_cards.count
  end

  def base_price
    total_cards = self.total_cards

    # THERE MUST BE A CLEANER WAY TO DO THIS.
    if total_cards <= 18
      6.00
    elsif total_cards <= 36
      9.60
    elsif total_cards <= 54
      12.00
    elsif total_cards <= 72
      16.00
    elsif total_cards <= 90
      20.00
    elsif total_cards <= 108
      24.00
    elsif total_cards <= 126
      28.00
    elsif total_cards <= 144
      32.00
    elsif total_cards <= 162
      36.00
    elsif total_cards <= 180
      40.00
    elsif total_cards <= 198
      44.00
    elsif total_cards <= 216
      48.00
    elsif total_cards <= 234
      52.00
    elsif total_cards <= 396
      83.00
    elsif total_cards <= 504
      103.60
    elsif total_cards <= 612
      122.40
    else
      130.00
    end
  end

  def price
    self.total_cards * 0.02 + self.base_price
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
      watermark: self.watermark,
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
      watermark: self.watermark,
      expansion: true,
      blackCards: self.black_cards,
      whiteCards: self.white_cards
    }
  end
end
