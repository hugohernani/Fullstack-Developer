class UserQuery
  def initialize(relation = User.all)
    @relation = relation.extending(Scopes)
  end

  def search
    @relation
  end

  module Scopes
    def grouped_by_role(role)
      where(User.arel_table[:role].eq(role)).count
    end

    def total_users
      User.count
    end
  end
end
