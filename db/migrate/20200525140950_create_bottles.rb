class CreateBottles < ActiveRecord::Migration[6.0]
  def change
    create_table :bottles do |t|
      t.references :wine, null: false, foreign_key: true
      t.references :cave, null: false, foreign_key: true
      t.integer :quantity
      t.text :comment
      t.date :apogee_start
      t.date :apogee_end
      t.string :liked

      t.timestamps
    end
  end
end
