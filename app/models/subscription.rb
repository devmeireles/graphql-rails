class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :subreddit

  validates :user_id, uniqueness: { scope: :subreddit_id }
end
