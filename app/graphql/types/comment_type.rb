module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :body, String, null: false
    field :author, UserType, null: false
    field :post, PostType, null: false
    field :parent_comment_id, ID, null: true
    field :replies, [ CommentType ], null: true
    field :vote_status, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    def vote_status
      return 0 unless context[:current_user]
      vote = object.votes.find_by(user: context[:current_user])
      vote ? vote.value_before_type_cast : 0
    end
  end
end
