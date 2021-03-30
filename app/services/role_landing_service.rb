class RoleLandingService < ObjectService
  initialize_with :resource, :context

  def perform
    {
      'admin': context.admin_root_path,
      'member': context.profile_path
    }.with_indifferent_access.fetch(resource.role, context.root_path)
  end
end
