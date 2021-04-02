class MockResource
  def role
    'admin'
  end
end

class MockRailsRoutes
  def method_missing(method_name, *_args)
    method_ends_with?(method_name.to_s) ? '/admin' : super
  end

  def respond_to_missing?(method_name, *_args)
    method_ends_with?(method_name.to_s) || super
  end

  private

  def method_ends_with?(method_name)
    method_name.ends_with?('_path')
  end
end

RSpec.shared_examples 'object service' do |service_target|
  subject(:object_service_instance_call) { service_target.new(resource: MockResource.new, context: context).perform }

  subject(:object_service_klass_call) { service_target.perform(resource: MockResource.new, context: context) }

  it 'expects perform class method to be the same as new call chain calls' do
    expect(object_service_klass_call).to eq(object_service_instance_call)
  end
end
