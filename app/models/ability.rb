class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      # user can only edit thier own account
      can [:edit, :update], User do |thisuser|
        thisuser.id == user.id 
      end
      can [:new, :create], 
        [User]
    end
  end
end
