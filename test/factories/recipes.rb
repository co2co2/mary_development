FactoryBot.define do
  factory :recipe do
    sequence(:id){|i| i}
    recipe_category
    strain
    title "bitmaker's pizza"
    description "The best pizza in the world."
    prep_time 30
    user
    # measurements {|m| [m.association(:measurement)]}
    # instructions {|i| [i.association(:instruction)]}
  end
end
