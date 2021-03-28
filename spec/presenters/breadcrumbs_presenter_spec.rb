require 'rails_helper'

describe BreadcrumbsPresenter do
  let(:path) { '/users' }
  let(:title) { 'Users' }

  let(:view_context) { instance_double('View Context') }

  describe 'when is valid' do
    subject(:valid_presenter) { described_class.new(valid_breadcrumb_options, view_context: view_context) }

    let(:valid_breadcrumb_options) do
      {
        root_path: path,
        root_title: title
      }
    end

    let(:mocked_breadcrumb_item_presenter) { instance_double(BreadcrumbItemPresenter, render: '<li></li>') }

    before do
      allow(BreadcrumbItemPresenter).to receive(:new).and_return(mocked_breadcrumb_item_presenter)
    end

    it 'render proper nav tag' do
      expected_result = "<nav aria-label=\"breadcrumb \" class=\"main-breadcrumb\">\n  <ol class=\"breadcrumb\">\n    #{mocked_breadcrumb_item_presenter.render}\n  </ol>\n</nav>\n"
      expect(valid_presenter.render).to eq(expected_result)
    end
  end

  describe 'when is not valid' do
    subject(:invalid_presenter) { described_class.new(invalid_breadcrumb_options, view_context: view_context) }

    let(:invalid_breadcrumb_options) do
      {}
    end

    it 'raises required attribute error' do
      expect { invalid_presenter.render }.to raise_error(StandardError)
    end
  end
end
