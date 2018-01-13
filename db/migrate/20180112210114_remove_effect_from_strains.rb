class RemoveEffectFromStrains < ActiveRecord::Migration[5.1]
  def change
    remove_column :strains, :effect, :string
  end
end
