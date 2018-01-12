class CreateEffects < ActiveRecord::Migration[5.1]
  def change
    create_table :effects do |t|
      t.string :name
      t.decimal :level
      t.string :subcategory
      t.string :image

      t.timestamps
    end
  end
end
