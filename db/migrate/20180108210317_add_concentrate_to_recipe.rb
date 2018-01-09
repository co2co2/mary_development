class AddConcentrateToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :concentrate, :boolean
  end
end
