FactoryBot.define do
  factory :bulk_upload do
    association :uploader, factory: :user
  end
end
