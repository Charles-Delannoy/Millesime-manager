class CreateAssemblages < ActiveRecord::Migration[6.0]
  def change
    create_table :assemblages do |t|
      t.integer :percentage
      t.references :wine, null: false, foreign_key: true
      t.references :cepage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
