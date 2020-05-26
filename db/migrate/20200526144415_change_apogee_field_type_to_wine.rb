class ChangeApogeeFieldTypeToWine < ActiveRecord::Migration[6.0]
  def change
    remove_column :wines, :apogee_start
    remove_column :wines, :apogee_end
    add_column :wines, :apogee_start, :integer
    add_column :wines, :apogee_end, :integer
  end
end
