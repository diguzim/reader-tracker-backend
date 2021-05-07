# frozen_string_literal: true

class CreateAuthorships < ActiveRecord::Migration[6.1]
  def change
    create_table :authorships do |t|
      t.references :author, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.boolean :main_contributor, null: false

      t.timestamps
    end
  end
end
