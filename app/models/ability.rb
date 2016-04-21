class Ability
  include CanCan::Ability

# cancancan automatically integrates with ApplicationController and it assumes you have a method in your ApplicationController called 'current_user'
# You dont need to automatically create an Ability object we just need to learn how to write authorization rules and how to use them
  def initialize(user)

    user ||= User.new

    # This lets the admin have super powers >_<
    can :manage, :all if user.admin?

    alias_action :create, :read, :update, :destroy, :to => :crud
    # defining the ability to :manage with a question
    # in this case we determine whether the user is allowed to manage a question or not
    can :crud, Question do |q|
      q.user == user
    end

    can :crud, Answer do |a|
      (a.question.user == user || a.user == user) && user.persisted?
    end

    can :like, Question do |q|
      q.user != user
    end

    can :destroy, Like do |l|
      l.user == user
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
