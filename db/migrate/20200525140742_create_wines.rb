class CreateWines < ActiveRecord::Migration[6.0]
  def change
    create_table :wines do |t|
      t.string :name
      t.integer :millesime
      t.date :apogee_start
      t.date :apogee_end
      t.string :color

      t.timestamps
    end
  end
end
