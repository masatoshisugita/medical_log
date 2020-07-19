class ChangeColumnToUser < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :name, :string, null: false,limit: 15
    change_column :users, :email, :string, null: false, limit: 255, unique: true
  end

  def down
    change_column :users, :name, :string, null: false
    change_column :users, :email, :string, null: false
  end
end
