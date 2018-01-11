class RenameRecommendedStrain < ActiveRecord::Migration[5.1]
  def change
  	    rename_column :recipes, :recommended_strain_id, :strain_id
  end
end
