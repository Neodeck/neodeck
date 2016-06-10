class AddCustomScriptToUsers < ActiveRecord::Migration
  def change
    add_column :users, :custom_script, :text
  end
end
