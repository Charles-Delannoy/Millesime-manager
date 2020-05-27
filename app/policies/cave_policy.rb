class CavePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user == record.user
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def new?
    create?
  end

  def update?
    user == record.user
  end


  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
