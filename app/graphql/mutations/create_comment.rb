module Mutations
  class CreateComment < BaseMutation
    argument :post_id, ID, required: true
    argument :body, String, required: true
    argument :parent_comment_id, ID, required: false

    type Types::CommentType

    def resolve(post_id:, body:, parent_comment_id: nil)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authorized" unless user

      Comment.create!(
        post_id: post_id,
        author: user,
        body: body,
        parent_comment_id: parent_comment_id
      )
    end
  end
end
