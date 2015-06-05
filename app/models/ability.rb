class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    # ____ Admin ____
    # Overlord + below
    # ____ Scholar ____
    # Same as Admin with some extra facilities
    # _____ Blogger _____
    # Registered User, Create, Posts, Comments + below
    # ____ User ____
    # Guest capabilities
    #

    user ||= User.new(:role_id=>4) # guest user (not logged in)
    #@user.role { |role| send(role) }
    if user.role == "Admin" || user.role == "Scholar"
       can :manage, :all
    else
        can :read, [Post, Blog, Comment, Notebook, Page, User, Audio]
          if Blog.any?{|b| b.post_access.include? user.id}
            can [:read,:create,:destroy], Authentication
          end
        if user.role == "Blogger"
          can :manage, Page do |n|
            Blog.any?{|b| b.post_access.include? user.id}
          end
           can :read , Notebook
           can :create, Notebook do |n|
            n.user_id == user.id
           end
           can :update, Notebook do |n|
            n.user_id == user.id
          end
           can :destroy, Notebook do |n|
            n.user_id == user.id
          end

          can :create, Post do |n|
            n.blog.post_access.include? user.id
          end
          can :update, Post do |n|
            n.author_id == user.id
          end
          can :destroy, Post do |n|
            n.author_id == user.id
          end
          # # Blogs
          #  can :read , Blog
          #  can :create, Blog do |b|
          #   b.user_id == user.id
          #   User.find(b.user_id).blogs.count < 1
          #  end
           can :update, Blog do |b|
               b.user_id == user.id || (b.post_access.include?user.id)
           end
           can :authorized_users, Blog do |b|
               b.user_id == user.id
           end
           can :invite_for_blog, Blog do |b|
               b.user_id == user.id
           end
          #  can :destroy, Blog do |b|
          #       b.user_id == user.id
          #  end
          # # Posts
          #  can :read , Post
          #  can :create, Post do |p|
          #   p.blog.user_id == user.id
          #  end
          #  can :update, Post do |p|
          #      p.blog.user_id == user.id
          #  end
          #  can :destroy, Post do |p|
          #       p.blog.user_id == user.id
          #  end
           # Comments Capabilities of a Blogger
           can :create, Comment
           can :update, Comment do |c|
             c.user_id == user.id
           end
           can :destroy, Comment do |c|
                c.user_id == user.id
            end
        elsif user.role == "Junior Editor"
           can :create, Notebook do |n|
            n.user_id == user.id
           end
           can :update, Notebook do |n|
            n.user_id == user.id
           end
           can :destroy, Notebook do |n|
            n.user_id == user.id
           end
          can :create, Post
          can :update, Post do |n|
            n.author_id == user.id
          end
          can :destroy, Post do |n|
            n.author_id == user.id
          end
           can :update, Blog do |b|
               b.user_id == user.id || (b.post_access.include?user.id)
           end
           can :authorized_users, Blog do |b|
               b.user_id == user.id
           end
           can :invite_for_blog, Blog do |b|
               b.user_id == user.id
           end
           can :create, Comment
           can :update, Comment do |c|
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

#   def Admin
#     can :manage, :all
#   end

#   def Blogger
#     can :create, Blog
#     can :update, Blog do |b|
#       b.user_id == @user.id
#     end
#     can :destroy, Blog do |b|
#       b.user_id == @user.id
#     end

#     can :create, Post do |p|
#       p.blog.user_id = @user.id
#     end
#     can :update, Post do |p|
#       p.blog.user_id == @user.id
#     end
#     can :destroy, Post do |p|
#       p.blog.user_id == @user.id
#     end

#     # Comments Capabilities of a Blogger
#     can :create, Comment
#     can :update, Comment do |c|
#       c.user_id == @user.id
#     end
#     can :destroy, Comment do |c|
#       c.user_id == @user.id
#     end

#   end
 end
