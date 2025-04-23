module Mutations
  class VotePost < BaseMutation
    argument :post_id, ID, required: true
    argument :value, Integer, required: true # +1 or -1

    type Types::PostType

    def resolve(post_id:, value:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authorized" unless user
      raise GraphQL::ExecutionError, "Invalid vote value" unless [ -1, 1 ].include?(value)

      vote = Vote.find_or_initialize_by(user: user, post_id: post_id)
      vote.update!(value: value)
      vote.post
    end
  end
end
