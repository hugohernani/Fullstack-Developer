class MissingRootBreadcrumbException < RuntimeError
  def initialize(msg = 'Missing root breadcrumb', exception_type = self.class)
    @exception_type = exception_type
    super(msg)
  end
end

module BreadcrumbsCollectable
  extend ActiveSupport::Concern

  included do |_base|
    extend ClassMethods
    helper_method :add_root_breadcrumb, :add_breadcrumb,
                  :breadcrumbs_collection
  end

  protected

  def add_root_breadcrumb(root_title, root_path, context: self)
    @breadcrumbs_collection = BreadcrumbsPresenter.new(
      {
        root_title: root_title,
        root_path: root_path
      },
      view_context: context
    )
  end

  def add_breadcrumb(title, path = '', opts = {})
    raise MissingRootBreadcrumbException unless @breadcrumbs_collection.is_a?(BreadcrumbsPresenter)

    css_classes = opts.delete(:css_classes) || ''
    @breadcrumbs_collection.add_breadcrumb(
      path: path,
      title: title,
      css_classes: css_classes
    )
  end

  def breadcrumbs_collection
    @breadcrumbs_collection ||= OpenStruct.new(render: '')
  end

  def missing_root_breadcrump?
    breadcrumbs_collection.is_a?(BreadcrumbsPresenter)
  end

  module ClassMethods
    def define_action_breadcrumb_for(resource_title, resource_path, actions = %w[new show edit])
      add_breadcrumb(resource_title, resource_path)
      define_action_breadcrumb(actions)
    end

    def define_action_breadcrumb(actions = %w[new show edit])
      before_action only: actions do
        add_breadcrumb(action_name.titleize, request.path)
      end
    end

    def add_breadcrumb(title, path = '', filter_opts = {})
      breadcrumb_opts = filter_opts.delete(:options) || {}
      root_flag = filter_opts.delete(:root) || false

      before_action(filter_opts) do |ctrl|
        if root_flag
          ctrl.send(:add_root_breadcrumb, title, path, context: ctrl.view_context)
        else
          ctrl.send(:add_breadcrumb, title, path, breadcrumb_opts)
        end
      end
    end
  end
end
