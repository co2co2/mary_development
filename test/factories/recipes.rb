FactoryBot.define do
  factory :recipe do
    recipe_category_id 1
    strain_id 1
    title "bitmaker's pizza"
    description "The best pizza in the world."
    prep_time 30
    user_id 1
  end
end
