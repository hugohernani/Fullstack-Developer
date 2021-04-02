require 'rails_helper'

class DummyCtrl < ActionController::Base
  include BreadcrumbsCollectable
end

describe BreadcrumbsCollectable, type: :controller do
  subject(:breadcrumbs_ctrl){ DummyCtrl.new }

  before do
    @ctrl_context = breadcrumbs_ctrl.view_context
  end

  describe '#add_root_breadcrumb' do
    context 'with a root breadcrumb' do
      let(:root_title){ 'Users' }
      let(:root_path){ 'admin/users' }

      it 'initializes presenter collection with root breadcrumb' do
        @ctrl_context.add_root_breadcrumb(root_title, root_path)
        expected_result = BreadcrumbsPresenter.new(
          { root_title: root_title, root_path: root_path }, view_context: @ctrl_context
        )
        expect(@ctrl_context.breadcrumbs_collection).to eq(expected_result)
      end
    end
  end

  describe '#add_breadcrumb' do
    context 'with a root breadcrumb' do
      let(:title){ 'Users' }
      let(:path){ 'admin/users' }

      context 'without a root breadcrumb' do
        it 'expects to raise MissingRootBreadcrumbException exception' do
          expect do
            @ctrl_context.add_breadcrumb(title, path)
          end.to raise_error(MissingRootBreadcrumbException)
        end
      end

      context 'with a defined root breadcrumb' do
        before do
          @ctrl_context.add_root_breadcrumb('Admin', 'admin')
        end

        it 'initializes presenter collection with root breadcrumb' do
          @ctrl_context.add_breadcrumb(title, path)
          expected_result = BreadcrumbItemPresenter.new(
            { title: title, path: path, css_classes: '' }, view_context: @ctrl_context
          )

          expect(@ctrl_context.breadcrumbs_collection.breadcrumbs).to include(expected_result)
        end
      end
    end
  end
end
