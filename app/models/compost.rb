class Compost < ApplicationRecord
  belongs_to :user
  validates :address, presence: :true
  validates :description, presence: :true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
