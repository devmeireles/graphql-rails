class User < ApplicationRecord
    has_many :posts, foreign_key: :author_id, dependent: :destroy
    has_many :comments, foreign_key: :author_id, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    has_many :subscribed_subreddits, through: :subscriptions, source: :subreddit
    has_many :created_subreddits, foreign_key: :creator_id, class_name: "Subreddit"

    validates :username, :email, presence: true, uniqueness: true
end
