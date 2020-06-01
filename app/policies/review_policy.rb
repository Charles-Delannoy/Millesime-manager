class ReviewPolicy < ApplicationPolicy

  def index?
    true
  end

  def update?
    record.user = user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
