FactoryBot.define do
  factory :review do
    comment 'Yummy!'
    association :user, factory: :user, strategy: :build
    association :recipe, factory: :recipe, strategy: :build
  end
end
