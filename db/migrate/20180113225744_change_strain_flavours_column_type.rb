class ChangeStrainFlavoursColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column :strains, :flavours, "varchar[] USING (string_to_array(flavours, ','))"
  end
end
