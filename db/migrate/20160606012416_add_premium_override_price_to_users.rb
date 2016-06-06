class AddPremiumOverridePriceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :premium_override_price, :integer
  end
end
