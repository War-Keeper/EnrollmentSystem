class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  enum role: [:student, :instructor, :admin]

  validates :role, inclusion: {in: roles.keys}

  validates :name, presence: true, length: {minimum: 1}

  validates :user_id, numericality: { only_integer: true }, presence:true

  validates :department, presence: true, length: {minimum: 2}, if: ->(user) {user.role == 'instructor'}
  validates :department, absence: true, if: ->(user) {user.role == 'student'}

  validates :major, presence: true, length: {minimum: 2}, if: ->(user) {user.role == 'student'}
  validates :major, absence: true, if: ->(user) {user.role == 'instructor'}

  validates :date_of_birth, presence: true, if: ->(user) {user.role == 'student'}
  validates :date_of_birth, absence: true, if: ->(user) {user.role == 'instructor'}

  validates :phone_number, presence: true, if: ->(user) {user.role == 'student'}, format: { with: /\A\d{10}\z|\A\\d{3}-?[\d]{3}-?[\d]{4}\z/, message: "Integers only, only 10 digits." }
  validates :phone_number, absence: true, if: ->(user) {user.role == 'instructor'}

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@.\s]+(?:\.[^@.\s]+)+\z/  }, uniqueness: true

  validates :user_id, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end


