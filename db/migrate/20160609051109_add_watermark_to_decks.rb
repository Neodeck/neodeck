class AddWatermarkToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :watermark, :string
  end
end
