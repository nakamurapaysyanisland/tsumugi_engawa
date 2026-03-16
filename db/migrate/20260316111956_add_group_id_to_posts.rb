class AddGroupIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :group_id, :integer

    add_foreign_key :posts, :groups

    add_index :posts, :group_id

    add_foreign_key :posts, :users

    add_foreign_key :posts, :categories
  end
end
