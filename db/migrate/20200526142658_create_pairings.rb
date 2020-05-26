class CreatePairings < ActiveRecord::Migration[6.0]
  def change
    create_table :pairings do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :wine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
