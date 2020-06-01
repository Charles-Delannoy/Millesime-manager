class RemoveLikedAndCommentFromBottles < ActiveRecord::Migration[6.0]
  def change
    remove_column :bottles, :liked
    remove_column :bottles, :comment
  end
end
