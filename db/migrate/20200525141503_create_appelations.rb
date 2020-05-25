class CreateAppelations < ActiveRecord::Migration[6.0]
  def change
    create_table :appelations do |t|
      t.references :region, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
