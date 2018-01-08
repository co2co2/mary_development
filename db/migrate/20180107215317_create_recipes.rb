class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.integer :category_id
      t.integer :recommended_strain_id
      t.string :title
      t.string :image
      t.string :video
      t.text :description
      t.integer :prep_time
      t.integer :views

      t.timestamps
    end
  end
end
