class CreateUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :units do |t|
      t.string :unit_name
      t.string :unit_description
      t.string :unit_content
      t.string :identifier
      t.integer :position
      t.references :chapter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
