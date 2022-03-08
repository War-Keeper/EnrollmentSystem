class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.string :instructor_name
      t.string :weekday_one
      t.string :weekday_two
      t.time :start_time
      t.time :end_time
      t.string :course_code
      t.integer :capacity
      t.integer :waitlist_capacity
      t.string :status
      t.string :room

      t.timestamps
    end
    add_index :courses, :course_code, unique: true
  end
end
