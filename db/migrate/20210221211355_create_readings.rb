class CreateReadings < ActiveRecord::Migration[6.1]
  def change
    create_table :readings do |t|
      t.references :book, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :finish_date
      t.integer :status

      t.timestamps
    end
  end
end
