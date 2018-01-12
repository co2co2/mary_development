class AddJoinTablesForAllergiesEffects < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :effects, :strains
  	create_join_table :allergies, :recipes
  end
end
