class AddColumnToCompany < ActiveRecord::Migration
  def change
    add_index :companies, :username, unique: true
  end
end
