class AddIdToRatings < ActiveRecord::Migration[5.1]
  def change
  	add_column :ratings, :id, :primary_key
  end
end
