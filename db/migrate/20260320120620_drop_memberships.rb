class DropMemberships < ActiveRecord::Migration[6.1]
  def change
    drop_table :memberships
  end
end
