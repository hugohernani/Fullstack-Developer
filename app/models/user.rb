class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :full_name, :role, presence: true

  enum role: { member: 0, admin: 1 }

  ## Associations
  has_one_attached :avatar_image

  def to_s
    full_name
  end

  def toggle_role
    new_role = admin? ? User.roles[:member] : User.roles[:admin]
    update(role: new_role)
  end
end
