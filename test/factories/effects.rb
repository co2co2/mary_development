FactoryBot.define do
  factory :effect do
    name 'happy'
    level 5.0
    subcategory ['positive','medical'].sample
    
  end
end
