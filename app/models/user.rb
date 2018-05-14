class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :composts
  has_many :conversations
  has_many :messages
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  mount_uploader :photo, PhotoUploader
end
