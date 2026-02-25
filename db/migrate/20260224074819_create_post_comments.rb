class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.text :content
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
