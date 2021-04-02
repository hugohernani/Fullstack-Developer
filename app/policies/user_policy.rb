class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def new?
    index?
  end

  def edit?
    index?
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end

  def can_toggle?
    new? && !himself?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.all if user.admin?

      scope.none
    end
  end

  private

  def himself?
    user.eql?(record)
  end
end
