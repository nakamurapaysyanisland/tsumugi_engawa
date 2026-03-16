class AddForeignKeyToGroupUsers < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :group_users, :users
    add_foreign_key :group_users, :groups
  end
end
