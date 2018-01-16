class AddNameToDispensaries < ActiveRecord::Migration[5.1]
  def change
    add_column :dispensaries, :name, :string
  end
end
