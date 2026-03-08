class DropSearchTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :searches do |t|
    
      t.string :content
      t.timestamps
    end
  end
end