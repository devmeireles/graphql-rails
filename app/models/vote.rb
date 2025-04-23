class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  enum value: { down: -1, up: 1 }

  validates :value, presence: true
  validates :user_id, uniqueness: { scope: :post_id }, if: -> { post_id.present? }
  validates :user_id, uniqueness: { scope: :comment_id }, if: -> { comment_id.present? }
end
