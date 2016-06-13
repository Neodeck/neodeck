class AddStripeChargeIdToDeckOrders < ActiveRecord::Migration
  def change
    add_column :deck_orders, :stripe_charge_id, :string
  end
end
