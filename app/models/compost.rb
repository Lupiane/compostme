class Compost < ApplicationRecord
  belongs_to :user
  validates :address, presence: :true
  validates :description, presence: :true
  has_many :conversations, dependent: :nullify

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
