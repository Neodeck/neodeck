class AddSocketAuthTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :socket_auth_token, :string
  end
end
