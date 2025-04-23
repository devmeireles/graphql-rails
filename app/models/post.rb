class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :subreddit
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :title, presence: true
end
