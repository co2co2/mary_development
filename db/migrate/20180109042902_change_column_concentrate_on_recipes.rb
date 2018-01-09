class ChangeColumnConcentrateOnRecipes < ActiveRecord::Migration[5.1]
  def change
    change_column :recipes, :concentrate, :boolean, :default => false
  end
end
