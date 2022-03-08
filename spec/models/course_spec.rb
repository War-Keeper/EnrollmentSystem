require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { Course.new(name: "Kant is a Cunt", description: "hello here it is...", instructor_name: "Richard Cunts", weekday_one: "MON", weekday_two: "WED", start_time: "06:00", end_time: "08:00", course_code: "abc800", capacity: 10, waitlist_capacity: 30, room: "HOL32") }

  before { subject.save }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "class name should be present" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it "class description should be present" do
    subject.description = nil
    expect(subject).to_not be_valid
  end
  it "instructor name should be present" do
    subject.instructor_name = nil
    expect(subject).to_not be_valid
  end
  it "weekday one name should be present" do
    subject.weekday_one = nil
    expect(subject).to_not be_valid
  end
  # it "start time should be present" do
  #   subject.start_time = nil
  #   expect(subject).to_not be_valid
  # end
  # it "end time should be present" do
  #   subject.end_time = nil
  #   expect(subject).to_not be_valid
  # end
  it "class code should be present" do
    subject.course_code = nil
    expect(subject).to_not be_valid
  end
  it "class capacity should be present" do
    subject.capacity = nil
    expect(subject).to_not be_valid
  end
  it "class waitlist capacity should be present" do
    subject.waitlist_capacity = nil
    expect(subject).to_not be_valid
  end
  it "class room should be present" do
    subject.room = nil
    expect(subject).to_not be_valid
  end
end