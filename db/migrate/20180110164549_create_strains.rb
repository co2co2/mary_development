class CreateStrains < ActiveRecord::Migration[5.1]
  def change
    create_table :strains do |t|
      t.string :name
      t.string :race
      t.string :flavours
      t.string :effect

      t.timestamps
    end
  end
end
