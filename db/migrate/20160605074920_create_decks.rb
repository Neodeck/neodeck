class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.text :white_cards
      t.text :black_cards

      t.timestamps null: false
    end
  end
end
