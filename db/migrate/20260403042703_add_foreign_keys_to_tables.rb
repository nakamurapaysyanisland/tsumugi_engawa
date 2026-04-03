class AddForeignKeysToTables < ActiveRecord::Migration[6.1]
  def change

    remove_column :posts, :user_id, :integer
    remove_column :posts, :category_id, :integer
    add_reference :posts, :user,     null: false, foreign_key: true
    add_reference :posts, :category, foreign_key: true

    remove_column :group_users, :user_id, :integer
    remove_column :group_users, :group_id, :integer
    add_reference :group_users, :user,  null: false, foreign_key: true
    add_reference :group_users, :group, null: false, foreign_key: true

    remove_column :post_comments, :user_id, :integer
    remove_column :post_comments, :post_id, :integer
    add_reference :post_comments, :user, null: false, foreign_key: true
    add_reference :post_comments, :post, null: false, foreign_key: true

    remove_column :favorites, :user_id, :integer
    remove_column :favorites, :post_id, :integer
    add_reference :favorites, :user, null: false, foreign_key: true
    add_reference :favorites, :post, null: false, foreign_key: true

  end
end