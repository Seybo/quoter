class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # byebug
    if user.role?(:super_admin)
      can :manage, :all
    elsif user.role?(:user)
      can :read, Quote
      can [:update, :destroy], Quote, user_id: user.id
      can :create, Quote
      # glaux here must set check for private quote later
    end
  end
end
