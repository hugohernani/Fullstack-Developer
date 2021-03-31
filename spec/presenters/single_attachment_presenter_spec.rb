require 'rails_helper'

describe SingleAttachmentPresenter do
  subject(:presenter){ described_class.new(storage_model, view_context: view_context) }

  let(:view_context) { instance_double('View Context', image_tag: nil) }

  describe 'when is renderable' do
    let(:storage_model) do
      instance_spy('Attached::One',
                   name: 'avatar_image',
                   attached?: true,
                   representable?: true,
                   representation: 'image-url')
    end

    it 'calls image_tag on view context' do
      presenter.render

      expect(view_context).to have_received(:image_tag)
    end

    it 'delegates resize parameter to storage_model representation method' do
      resize_limit = [385, 230]
      presenter.render(resize: resize_limit)

      expect(storage_model).to have_received(:representation).with(resize_to_limit: resize_limit)
    end

    it 'returns a html content' do
      expected_result = "<div class=\"avatar-image-container\">\n  \n</div>\n"
      expect(presenter.render).to eq expected_result
    end
  end
end
