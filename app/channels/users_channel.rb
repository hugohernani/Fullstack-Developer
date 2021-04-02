class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def toggle_user_role(payload)
    return unless UserPolicy.new(current_user, User).can_toggle?

    user = User.find(payload['user_id'])
    user.toggle_role

    UsersChannel.broadcast_to current_user, card_template: card_partial(user), user_id: user.id, is_admin: user.admin?
  end

  private

  def card_partial(user)
    ApplicationController.renderer.render(partial: 'admin/users/user_role_switcher', locals: { user: user })
  end
end
