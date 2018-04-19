class CompostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user == record.user || user.admin
  end

  def remove?
    user == record.user
  end

  def dashboard?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def user_composts?
    true
  end
end
