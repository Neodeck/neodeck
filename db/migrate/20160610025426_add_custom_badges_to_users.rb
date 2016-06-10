class AddCustomBadgesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :custom_badges, :text
  end
end
