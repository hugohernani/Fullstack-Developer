module BreadcrumbsValidatable
  def validate_required_breadcrumbs!(breadcrumbs_options, required_attrs: [])
    required_attrs_presence = required_attrs.all? do |required_attr|
      breadcrumbs_options.key?(required_attr)
    end
    required_attrs_presence || (raise StandardError, "Missing required attributes: #{required_attrs}")
  end
end
