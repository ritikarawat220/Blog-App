class Ability
  include CanCan::Ability

  def initialize(user)
    #   user ||= User.new
    user ||= current_user
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, [Post, Comment]
      can :update, [Post, Comment], author_id: user.id
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id
    end

    #   puts "User #{user.id} permissions:"
    #   puts "can destroy [@user, @post]: #{can? :destroy, [@user, @post]}"
    puts "User #{user.id} permissions:"
    puts "can destroy Post: #{can? :destroy, Post}"
  end
end
