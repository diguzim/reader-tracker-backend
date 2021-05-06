# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :readings, dependent: :destroy
  has_many :books
  has_many :authors

  def after_confirmation
    puts "\nshall do something after confirming\n\n"
  end
end
