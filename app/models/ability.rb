class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. 
    # ____ Admin ____
    # Overlord + below
    # ____ Scholar ____
    # Edit Any Comment, User + below
    # _____ Blogger _____
    # Registered User, Create, Posts, Comments + below
    # ____ User ____
    # Guest capabilities
    #

    user ||= User.new(:role_id=>4) # guest user (not logged in)

    if user.role == "Admin"
        can :manage, :all
    else
        can :read, :all
        if user.role == "Blogger"
           can :read , Post
           can :create, Post
           can :update, Post do |p|
               p.user_id == user.id 
           end
           can :destroy, Post do |p|
                p.user_id == user.id 
           end
           # Comments Capabilities of a Blogger
           can :create, Comment
           can :update, Comment do |c|
             c.user_id == user.id
           end
           can :destroy, Comment do |c|
                c.user_id == user.id
            end
        end
    end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
