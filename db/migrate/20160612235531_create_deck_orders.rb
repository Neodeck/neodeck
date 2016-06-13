class CreateDeckOrders < ActiveRecord::Migration
  def change
    create_table :deck_orders do |t|
      t.string :shipping_first_name
      t.string :shipping_last_name
      t.string :shipping_line_1
      t.string :shipping_line_2
      t.string :shipping_country
      t.string :shipping_city
      t.string :shipping_zip
      t.boolean :shipped
      t.string :tracking_number
      t.float :base_price
      t.float :shipping_price
      t.integer :user_id
      t.integer :deck_id

      t.timestamps null: false
    end
  end
end
