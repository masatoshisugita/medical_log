class ChangeColumnToComment < ActiveRecord::Migration[6.0]
  def up
    change_column :comments, :review, :string, null: false, limit: 150
    change_column :comments, :user_id, :integer, null: false
    change_column :comments, :topic_id, :integer, null: false
  end

  def down
    change_column :comments, :review, :string
    change_column :comments, :user_id, :integer
    change_column :comments, :topic_id, :integer
  end
end
