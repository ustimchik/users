FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end
  sequence :name do |n|
    "Test#{n}name"
  end
  factory :user do
    email
    name
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
