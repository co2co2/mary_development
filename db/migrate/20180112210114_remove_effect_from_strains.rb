class RemoveEffectFromStrains < ActiveRecord::Migration[5.1]
  def up
    remove_column :strains, :effect, :string
  end
end
