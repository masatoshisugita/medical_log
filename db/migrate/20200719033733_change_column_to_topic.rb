class ChangeColumnToTopic < ActiveRecord::Migration[6.0]
  def up
    change_column :topics, :user_id, :integer, null: false
    change_column :topics, :sick_name, :string, null: false, limit: 30
    change_column :topics, :period, :string, limit: 20
    change_column :topics, :initial_symptom, :string, limit: 50
    change_column :topics, :content, :text, null: false, limit: 400
  end

  def down
    change_column :topics, :user_id, :integer
    change_column :topics, :sick_name, :string
    change_column :topics, :period, :string
    change_column :topics, :initial_symptom, :string
    change_column :topics, :content, :text
  end
end
