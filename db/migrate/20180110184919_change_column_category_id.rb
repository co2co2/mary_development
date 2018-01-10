class ChangeColumnCategoryId < ActiveRecord::Migration[5.1]
  def change
    rename_column :recipes, :category_id, :recipe_category_id
  end
end
