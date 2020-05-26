class CavePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user = record.user
  end

  def create?
    true
  end

  def new?
    create?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
