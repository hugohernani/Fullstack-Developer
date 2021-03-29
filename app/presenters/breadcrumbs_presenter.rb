class BreadcrumbsPresenter < BasePresenter
  include BreadcrumbsValidatable

  def initialize(breadcrumbs_options, view_context:)
    super()
    validate_required_breadcrumbs!(breadcrumbs_options, required_attrs: %i[root_path root_title])

    @view_context = view_context
    init_breadcrumbs(breadcrumbs_options)
    yield self if block_given?
  end

  def add_breadcrumb(breadcrumb_opts)
    @breadcrumbs << BreadcrumbItemPresenter.new(breadcrumb_opts, view_context: view_context)
  end

  def render
    <<~HTML
      <nav aria-label="breadcrumb #{css_classes}" class="main-breadcrumb">
        <ol class="breadcrumb">
          #{render_breadcrumbs}
        </ol>
      </nav>
    HTML
  end

  attr_accessor :breadcrumbs, :view_context, :css_classes

  def init_breadcrumbs(breadcrumbs_options)
    @breadcrumbs = []
    @breadcrumbs << BreadcrumbItemPresenter.new(
      {
        path: breadcrumbs_options.fetch(:root_path),
        title: breadcrumbs_options.fetch(:root_title),
        css_classes: breadcrumbs_options.fetch(:css_classes, {})
      },
      view_context: view_context
    )
  end

  def render_breadcrumbs
    @breadcrumbs.map do |breadcrumb|
      breadcrumb.path = '' if breadcrumb.css_classes.include?('active')
      breadcrumb.render
    end.join
  end
end
