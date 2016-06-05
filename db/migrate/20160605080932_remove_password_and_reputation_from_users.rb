class RemovePasswordAndReputationFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password
    remove_column :users, :reputation
  end
end
