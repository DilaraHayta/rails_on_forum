class AddColumnToTopic < ActiveRecord::Migration
  def change
  	add_reference :topics, :company, index: true
  end
end
