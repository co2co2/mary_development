class ChangeColumnConcentrateOnRecipes < ActiveRecord::Migration[5.1]
  def up
    change_column :recipes, :concentrate, :boolean, :default => false
  end
end
