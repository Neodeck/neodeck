class AddStripeChargeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_charge_id, :string
  end
end
