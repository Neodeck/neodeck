class RemoveFirstNameAndLastNameFromDeckOrders < ActiveRecord::Migration
  def change
    remove_column :deck_orders, :shipping_first_name, :string
    remove_column :deck_orders, :shipping_last_name, :string
    add_column :deck_orders, :shipping_name, :string
  end
end
