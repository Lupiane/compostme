
class UserValidator < ActiveModel::Validator
  def validate(record)
    if record.user == record.compost.user
      record.errors[:base] << "A conversation must be between two different users"
    end
  end
end

class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :compost
  has_many :messages
  validates_with UserValidator
  validates :compost, uniqueness: { scope: :user,
    message: "A conversation between this user and this compost owner already exists" }
end
