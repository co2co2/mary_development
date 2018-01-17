FactoryBot.define do
  factory :user do
    sequence(:username){|i| "user#{i}"}
    sequence(:email){|n| "user_#{n}@example.com"}
    password "password"
    password_confirmation "password"
    
  end
end
