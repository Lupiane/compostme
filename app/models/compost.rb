class Compost < ApplicationRecord
  belongs_to :user
  validates :address, presence: :true
  validates :type, presence: :true, inclusion: in: ["Public", "Private"]
  validates :description, presence: :true
end
