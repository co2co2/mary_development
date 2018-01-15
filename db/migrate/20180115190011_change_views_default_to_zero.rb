class ChangeViewsDefaultToZero < ActiveRecord::Migration[5.1]
  def change
    change_column :recipes, :views, :integer, default: 0

  end
end
