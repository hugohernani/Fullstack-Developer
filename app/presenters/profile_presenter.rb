class ProfilePresenter < BasePresenter
  def initialize(user, _view_context)
    super(user)
  end

  def edit_link
    {
      admin: admin_edit_profile_path
    }.with_indifferent_access.fetch(object.role, edit_profile_path)
  end

  def return_link
    {
      admin: admin_profile_path
    }.with_indifferent_access.fetch(object.role, profile_path)
  end

  def update_link
    {
      admin: admin_update_profile_path
    }.with_indifferent_access.fetch(object.role, update_profile_path)
  end
end
