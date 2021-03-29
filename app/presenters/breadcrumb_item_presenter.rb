class BreadcrumbItemPresenter < BasePresenter
  include BreadcrumbsValidatable

  attr_accessor :path, :css_classes

  def initialize(breadcrumb_options, view_context:)
    super(breadcrumb_options)
    validate_required_breadcrumbs!(breadcrumb_options, required_attrs: %i[path title])
    @path         = breadcrumb_options.fetch(:path)
    @title        = breadcrumb_options.fetch(:title)
    @css_classes  = breadcrumb_options.fetch(:css_classes, '')
    @view_context = view_context
  end

  def render
    <<~HTML
      <li class="breadcrumb-item #{css_classes}">
        #{set_link}
      </li>
    HTML
  end

  private

  attr_accessor :title, :view_context

  def set_link
    path.present? ? (view_context.link_to title, path) : title
  end
end
