class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.text :description
      t.integer :credits
      t.string :period
      t.string :department
      t.string :rating

      t.timestamps null: false
    end
  end
end
