class MoveImageColumnFromEffectsToStrains < ActiveRecord::Migration[5.1]
  def change
    remove_column :effects, :image, :string
    add_column :strains, :image, :string
  end
end
