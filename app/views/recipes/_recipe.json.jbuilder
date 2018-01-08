json.extract! recipe, :id, :category_id, :recommended_strain_id, :title, :image, :video, :description, :prep_time, :views, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
