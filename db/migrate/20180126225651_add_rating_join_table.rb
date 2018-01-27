class AddRatingJoinTable < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :users, :recipes, table_name: :ratings do |t|
  		t.decimal :rating
  		t.index :user_id
  		t.index :recipe_id
  	end
  end
end
