module Types
  class QueryType < Types::BaseObject
    field :users, [ UserType ], null: false
    field :blogs, [ BlogType ], null: false
    field :user, UserType, null: true do
      argument :id, ID, required: true
    end
    field :blog, BlogType, null: true do
      argument :id, ID, required: true
    end

    def users
      User.all
    end

    def blogs
      Blog.all
    end

    def user(id:)
      User.find_by(id: id)
    end

    def blog(id:)
      Blog.find_by(id: id)
    end
  end
end
