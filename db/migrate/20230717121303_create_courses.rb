class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_name, null: false
      t.string :instructor_name, null: false
      t.string :course_description, null: false
      t.string :identifier
      t.integer :position

      t.timestamps
    end
  end
end
