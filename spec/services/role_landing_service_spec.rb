require 'rails_helper'

describe RoleLandingService do
  subject(:service) { described_class.new(resource: resource, context: context) }

  let(:context) { instance_double('Rails Routes', profile_path: '/profile', admin_root_path: '/admin', root_path: '/') }

  it_behaves_like 'object service', described_class

  context 'when resource is admin' do
    let(:resource) { instance_double(User, role: 'admin') }

    it 'expects to return admin root path' do
      expect(service.perform).to eq(context.admin_root_path)
    end
  end

  context 'when resource is user' do
    let(:resource) { instance_double(User, role: 'member') }

    it 'expects to return user profile path' do
      expect(service.perform).to eq(context.profile_path)
    end
  end

  context "when resource's role is not covered" do
    let(:resource) { instance_double(User, role: 'unknown_role') }

    it 'expects to return root path' do
      expect(service.perform).to eq(context.root_path)
    end
  end
end
