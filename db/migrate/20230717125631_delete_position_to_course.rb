class DeletePositionToCourse < ActiveRecord::Migration[7.0]
  def change
    remove_column :courses, :position
  end
end
