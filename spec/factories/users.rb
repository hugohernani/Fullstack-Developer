FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    role { User.roles[:member] }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      role { User.roles[:admin] }
    end

    trait :member do
      role { User.roles[:member] }
    end
  end
end
