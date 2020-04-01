class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.string :sick_name
      t.string :period
      t.string :initial_symptom
      t.text :content

      t.timestamps
    end
  end
end
