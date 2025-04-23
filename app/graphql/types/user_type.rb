module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :email, String, null: false
    field :karma, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
