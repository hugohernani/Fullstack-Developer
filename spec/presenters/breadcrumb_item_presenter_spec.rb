require 'rails_helper'

describe BreadcrumbItemPresenter do
  let(:path) { '/users' }
  let(:title) { 'Users' }

  let(:generated_link) { "<a href='#{path}'>#{title}</a>" }

  let(:view_context) { instance_double('View Context', link_to: generated_link) }

  describe 'when is valid' do
    subject(:valid_presenter) { described_class.new(valid_breadcrumb_options, view_context: view_context) }

    let(:valid_breadcrumb_options) do
      {
        path: path,
        title: title
      }
    end

    it 'render proper list item' do
      expected_result = "<li class=\"breadcrumb-item \">\n  #{generated_link}\n</li>\n"
      expect(valid_presenter.render).to eq(expected_result)
    end
  end

  describe 'when is not valid' do
    subject(:invalid_presenter) { described_class.new(invalid_breadcrumb_options, view_context: view_context) }

    let(:invalid_breadcrumb_options) do
      {
      }
    end

    it 'raises required attribute error' do
      expect { invalid_presenter.render }.to raise_error(StandardError)
    end
  end
end
