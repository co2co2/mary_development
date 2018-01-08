class CreateMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :measurements do |t|
      t.string :quantity
      t.belongs_to :recipe, foreign_key: true
      t.belongs_to :ingredient, foreign_key: true

      t.timestamps
    end
  end
end
