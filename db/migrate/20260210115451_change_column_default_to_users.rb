class ChangeColumnDefaultToUsers < ActiveRecord::Migration[6.1]
  change_column_default :users, :role, from: nil, to: 0
end
