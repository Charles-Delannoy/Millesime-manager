class BottlePolicy < ApplicationPolicy

  def create?
    true
  end

  def new?
    create?
  end

  def show?
    record.cave.user = user
  end

  def edit?
    update?
  end

  def update?
    record.cave.user = user
  end


  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
