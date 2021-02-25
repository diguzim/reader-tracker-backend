class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # def password_required?
  #   false
  # end

  def after_confirmation
    puts "\nshall do something after confirming\n\n"
  end
end
