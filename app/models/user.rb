class User < ApplicationRecord
  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true
  validates :email, presence: true
  validates :first_name, presence: true, allow_nil: true


  belongs_to :city, optional: true
  has_many :gossips
  has_many :comments
  
  has_many :likes, dependent: :destroy
end
