class AddVerifiedToTwoFactorMethods < ActiveRecord::Migration
  def change
    add_column :two_factor_methods, :verified, :boolean
  end
end
