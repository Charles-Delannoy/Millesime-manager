class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wine, null: false, foreign_key: true
      t.boolean :liked
      t.text :comment

      t.timestamps
    end
  end
end
