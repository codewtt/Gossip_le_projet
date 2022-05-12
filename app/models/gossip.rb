class Gossip < ApplicationRecord

  belongs_to :user, optional: true
  has_many :tag_gossips
  has_many :tags, through: :tag_gossips
  has_many :comments
  
  validates :title, presence: true, length: {in: 3..50}
  validates :content, presence: true
  has_many :likes, dependent: :destroy
end
