# frozen_string_literal: true

class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    @user = user
    if @user
      @user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  protected

  def guest_abilities
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    can :index, WelcomeController
  end
end