class Compost < ApplicationRecord
  belongs_to :user
  validates :address, presence: :true
  validates :type, presence: :true
  validates :description, presence: :true
end
