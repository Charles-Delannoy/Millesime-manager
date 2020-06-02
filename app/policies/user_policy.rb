class UserPolicy < ApplicationPolicy

  def index?
    true
  end

  def edit?
    update?
  end

  def update?
    user == record.user
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
