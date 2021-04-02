class ProfilePolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    show?
  end

  def update?
    show?
  end
end
