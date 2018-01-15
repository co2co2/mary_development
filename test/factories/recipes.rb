FactoryBot.define do
  factory :recipe do
    recipe_category
    strain
    title "bitmaker's pizza"
    description "The best pizza in the world."
    prep_time 30
    user
    created_at Time.now
  
  end
end
