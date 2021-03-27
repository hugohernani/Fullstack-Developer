FactoryBot.define do
  factory :user do
    full_name { Faker::Name.full_name }
    role { User.roles[:no_admin] }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
