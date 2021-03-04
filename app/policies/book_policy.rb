# frozen_string_literal: true

class BookPolicy
  attr_reader :user, :book

  def initialize(user, book)
    @user = user
    @book = book
  end

  def update?
    user.id == book.user_id
  end
end
