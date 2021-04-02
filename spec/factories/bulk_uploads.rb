FactoryBot.define do
  factory :bulk_upload do
    association :uploader, factory: :user

    after(:build) do |bulk_upload|
      bulk_upload.file.attach(Rack::Test::UploadedFile.new(
                                Rails.root.join('spec/fixtures/files/user-bulk.xlsx'),
                                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
                              ))
    end
  end
end
