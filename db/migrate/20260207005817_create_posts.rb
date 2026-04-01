class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
	  t.string :title
	  t.string :body
	  t.bigint :user_id
	  t.bigint :category_id
	  t.datetime :deleted_at
	  t.timestamps
	end
      add_index :users, :nickname
      add_index :posts, :title      
      add_index :posts, :body

  
  end
end
