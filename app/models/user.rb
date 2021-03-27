class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :full_name, :role, presence: true

  enum role: { no_admin: 0, admin: 1 }
end
