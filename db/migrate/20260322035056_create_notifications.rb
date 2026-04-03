class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.bigint :visitor_id, null: false
      t.bigint :visited_id, null: false
      

      t.references :post,    foreign_key: true
      t.references :comment, foreign_key: { to_table: :post_comments }
      t.references :group,   foreign_key: true

      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end

    add_foreign_key :notifications, :users, column: :visitor_id
    add_foreign_key :notifications, :users, column: :visited_id
    
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
  end
end
