class AddUserIdToBooksAndReadings < ActiveRecord::Migration[6.1]
  def change
    add_reference :books, :user, foreign_key: true
    add_reference :readings, :user, foreign_key: true
  end
end
