# frozen_string_literal: true

class AuthorPolicy
  attr_reader :user, :author

  def initialize(user, author)
    @user = user
    @author = author
  end

  def update?
    user.id == author.user_id
  end

  def destroy?
    user.id == author.user_id
  end
end
