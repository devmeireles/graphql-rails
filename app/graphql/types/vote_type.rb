module Types
  class VoteType < Types::BaseObject
    field :id, ID, null: false
    field :value, Integer, null: false
    field :user, UserType, null: false
    field :post, PostType, null: true
    field :comment, CommentType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
