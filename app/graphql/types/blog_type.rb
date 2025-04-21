module Types
  class BlogType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :description, String, null: true
    field :user, Types::UserType, null: false
  end
end
