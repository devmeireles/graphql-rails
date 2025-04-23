module Types
  class SubredditType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :creator, UserType, null: false
    field :posts, [ PostType ], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
