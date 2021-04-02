require 'rails_helper'

describe FactoryStoragePresenter do
  subject(:factory){ described_class.for(storage_model, view_context: view_context) }

  let(:view_context) { instance_double('View Context') }

  describe 'when it does not know the attachment class' do
    let(:storage_model) do
      instance_spy('Unknown')
    end

    it 'raises UnknownStorageModelException' do
      expect do
        factory
      end.to raise_error(UnknownStorageModelException)
    end
  end
end
