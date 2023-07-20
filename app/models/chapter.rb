class Chapter < ApplicationRecord
  belongs_to :course
  acts_as_list scope: :course

  before_validation :set_identifier, on: :create

  validates :chapter_name, presence: true
  validates :identifier, presence: true, uniqueness: true

  has_many :units

  private

  def set_identifier
    self.identifier = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)

      break token unless Chapter.where(identifier: token).exists?
    end
  end
end
