class AddUniqueIndexToDoses < ActiveRecord::Migration[6.0]
  def change
    add_index :doses, %i[cocktail_id ingredient_id], unique: true
  end
end
