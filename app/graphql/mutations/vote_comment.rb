module Mutations
  class VoteComment < BaseMutation
    argument :comment_id, ID, required: true
    argument :value, Integer, required: true # +1 or -1

    type Types::CommentType

    def resolve(comment_id:, value:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authorized" unless user
      raise GraphQL::ExecutionError, "Invalid vote value" unless [ -1, 1 ].include?(value)

      vote = Vote.find_or_initialize_by(user: user, comment_id: comment_id)
      vote.update!(value: value)
      vote.comment
    end
  end
end
