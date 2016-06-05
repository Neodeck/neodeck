class CreateSocketApiApplications < ActiveRecord::Migration
  def change
    create_table :socket_api_applications do |t|
      t.string :token
      t.string :secret

      t.timestamps null: false
    end
  end
end
