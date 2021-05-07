# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    remove_column :books, :author, :string
  end
end
