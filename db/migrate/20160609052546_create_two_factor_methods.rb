class CreateTwoFactorMethods < ActiveRecord::Migration
  def change
    create_table :two_factor_methods do |t|
      t.integer :user_id
      t.string :secret

      t.timestamps null: false
    end
  end
end
