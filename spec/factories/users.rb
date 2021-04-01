FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    role { :member }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      role { :admin }
    end

    trait :member do
      role { :member }
    end
  end
end
