class RenameContentColumnToComments < ActiveRecord::Migration[6.0]
  def change
     rename_column :comments, :content, :review
  end
end
