module BreadcrumbsHelper
  def render_breadcrumbs
    ctrl_scope = controller_path.split('/')
    scoped_root_path, scoped_title = root_path_title(ctrl_scope.shift)
    breadcrumbs = add_root_breadcrumb(scoped_root_path, scoped_title)
    add_remaining_breadcrumbs(breadcrumbs, scoped_root_path, ctrl_scope)
    breadcrumbs.render
  end

  private

  def add_root_breadcrumb(scoped_root_path, scoped_title)
    BreadcrumbsPresenter.new({ root_path: scoped_root_path, root_title: scoped_title },
                             view_context: self)
  end

  def add_remaining_breadcrumbs(breadcrumbs, root_path, ctrl_scope)
    ctrl_scope.each do |current_path|
      breadcrumbs.add_breadcrumb(
        path: url_for([root_path[1..], current_path]),
        title: current_path.titleize
      )
    end
  end

  def root_path_title(first_path)
    {
      'admin': ['/admin', 'Admin']
    }.with_indifferent_access.fetch(first_path, ['/', 'Home'])
  end
end
