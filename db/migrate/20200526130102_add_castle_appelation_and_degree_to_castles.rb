class AddCastleAppelationAndDegreeToCastles < ActiveRecord::Migration[6.0]
  def change
    add_column :wines, :degree, :integer
    add_reference :wines, :castle, foreign_key: true
    add_reference :wines, :appelation, foreign_key: true
  end
end
