class CreateChapters < ActiveRecord::Migration[7.0]
  def change
    create_table :chapters do |t|
      t.string :chapter_name, null: false
      t.references :course, null: false, foreign_key: true
      t.string :identifier
      t.integer :position

      t.timestamps
    end
  end
end
