class AddStudentId < ActiveRecord::Migration[7.0]
  def change
    add_column :enrollments, :student_id, :integer
  end
end
