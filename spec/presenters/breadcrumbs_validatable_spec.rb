require 'rails_helper'

class DummyClass
  include BreadcrumbsValidatable
end

describe BreadcrumbsValidatable do
  describe '#validate_required_breadcrumbs!' do
    subject(:required_breadcrumbs) do
      DummyClass.new.validate_required_breadcrumbs!(
        attrs_hash,
        required_attrs: required_attrs
      )
    end

    let(:attrs_hash) { { attr1: 'test' } }

    let(:required_attrs) { [:attr1] }

    it 'returns true when required parameters are present' do
      expect(required_breadcrumbs).to be_truthy
    end
  end
end
