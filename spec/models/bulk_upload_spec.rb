require 'rails_helper'

RSpec.describe BulkUpload, type: :model do
  %i[uploader].each do |attr|
    it { is_expected.to belong_to(attr) }
  end
end
