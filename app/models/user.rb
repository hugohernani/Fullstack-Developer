class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :full_name, :role, presence: true

  enum role: { member: 0, admin: 1 }

  def to_s
    full_name
  end
end
