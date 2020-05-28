class AddIconToMeal < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :icon, :string
  end
end
