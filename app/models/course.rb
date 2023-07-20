class Course < ApplicationRecord
  before_validation :set_identifier, on: :create

  validates :course_name, presence: true
  validates :instructor_name, presence: true
  validates :course_description, presence: true
  validates :identifier, uniqueness: true

  has_many :chapters

  private

  def set_identifier
    self.identifier = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)

      break token unless Course.where(identifier: token).exists?
    end
  end
end
