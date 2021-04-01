class User < ApplicationRecord
  PASSWORD_REQUIRED_PATTERN = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :full_name, :role, presence: true
  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
  validate :password_complexity, on: :create

  enum role: { member: 0, admin: 1 }

  ## Associations
  has_one_attached :avatar_image do |attachable|
    attachable.variant :thumb, resize: '100x100'
    attachable.variant :medium, resize: '350x350'
  end

  def to_s
    full_name
  end

  def toggle_role
    new_role = admin? ? User.roles[:member] : User.roles[:admin]
    update(role: new_role)
  end

  private

  def password_complexity
    return if password =~ PASSWORD_REQUIRED_PATTERN

    errors.add :password, "Complexity requirement not met.
                Length should be 8-70 characters and include:
                1 uppercase, 1 lowercase,
                1 digit and 1 special character"
  end
end
