# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :genre
      t.integer :pages
      t.integer :relevance

      t.timestamps
    end
  end
end
