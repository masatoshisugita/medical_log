class ChangeColumnToRelationship < ActiveRecord::Migration[6.0]
  def up
    change_column :relationships, :follower_id, :integer, null: false
    change_column :relationships, :followed_id, :integer, null: false
  end

  def down
    change_column :relationships, :follower_id, :integer
    change_column :relationships, :followed_id, :integer
  end
end
