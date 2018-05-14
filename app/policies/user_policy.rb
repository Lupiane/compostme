class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def impersonate?
    true
  end

  def stop_impersonating?
    true
  end
end
