class Course < ApplicationRecord
  has_many :instructors

  has_many :enrollments, dependent: :destroy

  enum weekday: [:MON, :TUE, :WED, :THU, :FRI]
  validates :name, length: { minimum: 2 }
  validates :description, length: { minimum: 2 }
  validates :instructor_name, format: { with: /\A[a-zA-Z. ]+\z/, message: "only allows letters" }
  validates :weekday_one, inclusion: {in: weekdays.keys}
  validate :weekday_uniqueness
  validate :time_after
  validates :course_code, format: { with: /\A[a-zA-Z][a-zA-Z][a-zA-Z][0-9][0-9][0-9]\z/, message: ": Must be in ABC123 Format" }, uniqueness: true
  validates :capacity, length: { minimum: 0 }
  validates :waitlist_capacity, length: { minimum: 0 }
  validates :room, length: { minimum: 2 }

  private

  def weekday_uniqueness
    errors.add(:weekday_two, ": Day one can't be the same as day two") if weekday_two == weekday_one
    unless
    weekday_two.nil?
    end
  end

  def time_after
    errors.add(:start_time, ": Start time can't be after end time") if start_time.after?(end_time)
  end
end
