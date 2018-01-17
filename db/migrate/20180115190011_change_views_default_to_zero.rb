class ChangeViewsDefaultToZero < ActiveRecord::Migration[5.1]
  def up
    change_column :recipes, :views, :integer, default: 0

  end
end
