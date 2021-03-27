require 'rails_helper'

RSpec.describe User, type: :model do
  %i[email full_name role].each do |attr|
    it { is_expected.to validate_presence_of(attr) }
  end
end
