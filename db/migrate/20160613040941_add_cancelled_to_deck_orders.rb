class AddCancelledToDeckOrders < ActiveRecord::Migration
  def change
    add_column :deck_orders, :cancelled, :boolean
  end
end
