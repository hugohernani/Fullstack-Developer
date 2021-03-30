module BreadcrumbsHelper
  def render_breadcrumbs
    ctrl_scope                     = request.path[1..].split('/') # i.e ['admin', 'users', '1', 'edit']
    scoped_root_path, scoped_title = root_path_title(ctrl_scope.shift) # i.e. [admin Admin]
    breadcrumbs                    = add_root_breadcrumb(scoped_root_path, scoped_title)
    add_remaining_breadcrumbs(breadcrumbs, ctrl_scope) if ctrl_scope.length.positive?
    breadcrumbs.render
  end

  private

  def add_root_breadcrumb(scoped_root_path, scoped_title)
    BreadcrumbsPresenter.new(
      {
        root_path: "/#{scoped_root_path}",
        root_title: scoped_title
      },
      view_context: self
    )
  end

  def add_remaining_breadcrumbs(breadcrumbs, ctrl_scope)
    remaining_paths = ctrl_scope.shift(ctrl_scope.length - 1)
    last_path       = ctrl_scope.shift
    remaining_paths.each { |curr_path| add_breadcrumb(breadcrumbs, curr_path) }
    add_breadcrumb(breadcrumbs, last_path, 'active')
  end

  def add_breadcrumb(breadcrumbs, current_path, css_classes = '')
    breadcrumbs.add_breadcrumb(
      path: url_for(controller: controller_path, action: matching_action(current_path)),
      title: path_title(current_path),
      css_classes: css_classes
    )
  end

  def path_title(path)
    return t("breadcrumbs.#{action_name}", res: controller_name.singularize.titleize) if path.presence_in(%w[new edit])

    path.titleize
  end

  def root_path_title(first_path)
    {
      'admin': %w[admin Admin],
      'profile': %w[profile Profile]
    }.with_indifferent_access.fetch(first_path, ['', 'Home'])
  end

  def matching_action(current_path)
    return :show if current_path.match(/\d+|profile|edit/) && action_name.presence_in(%w[show edit])
  end
end
