class Subreddit < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :posts, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  validates :name, presence: true, uniqueness: true
end
