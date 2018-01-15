class ChangeStrainFlavoursColumnType < ActiveRecord::Migration[5.1]
  def up
    change_column :strains, :flavours, "varchar[] USING (string_to_array(flavours, ','))"
  end
end
