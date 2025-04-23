module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: true
    field :image_url, String, null: true
    field :author, UserType, null: false
    field :subreddit, SubredditType, null: false
    field :comments, [ CommentType ], null: true
    field :vote_status, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    def vote_status
      return 0 unless context[:current_user]
      vote = object.votes.find_by(user: context[:current_user])
      vote ? vote.value_before_type_cast : 0
    end
  end
end
