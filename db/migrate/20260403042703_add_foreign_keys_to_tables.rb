class AddForeignKeysToTables < ActiveRecord::Migration[6.1]
  def change

    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :posts

    add_foreign_key :post_comments, :users
    add_foreign_key :post_comments, :posts

    add_foreign_key :notifications, :users, column: :visitor_id
    add_foreign_key :notifications, :users, column: :visited_id
    add_foreign_key :notifications, :posts
    add_foreign_key :notifications, :post_comments, column: :comment_id
    add_foreign_key :notifications, :groups
  end
end
