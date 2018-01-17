
FactoryBot.define do
  factory :recipe_category do
    sequence(:id){|i| i}
    name {['Desserts','Asdas','asdas'].sample}
  end
end
