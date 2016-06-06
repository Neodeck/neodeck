class AddPremiumDiscountPercentageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :premium_discount_percentage, :integer
  end
end
