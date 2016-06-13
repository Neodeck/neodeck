class AddShippingStateToDeckOrders < ActiveRecord::Migration
  def change
    add_column :deck_orders, :shipping_state, :string
  end
end
