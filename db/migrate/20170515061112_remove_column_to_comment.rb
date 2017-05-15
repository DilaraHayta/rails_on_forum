class RemoveColumnToComment < ActiveRecord::Migration
  def change
    remove_column :comments, :body
  end
end
