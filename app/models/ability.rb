class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.role == "admin"  
      can :manage, :all 
    else
      can :read, :all
      #can :manage, user
      #can :sign_in
      can :manage, User , :id => user.id
    end
  end
end