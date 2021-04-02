RSpec.shared_examples 'simple delegator presenter' do |presenter|
  subject { presenter.new(resource, view_context) }

  let(:view_context) { instance_double('View Context') }

  it 'makes object targetting decorated resource' do
    expect(subject.__getobj__).to eq resource
  end
end
