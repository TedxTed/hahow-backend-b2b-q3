class Unit < ApplicationRecord
  belongs_to :chapter
  acts_as_list scope: :chapter

  before_validation :set_identifier, on: :create

  validates :unit_name, presence: true
  validates :unit_content, presence: true
  validates :identifier, presence: true, uniqueness: true

  private

  def set_identifier
    self.identifier = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)

      break token unless Unit.where(identifier: token).exists?
    end
  end
end
