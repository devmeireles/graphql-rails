module Mutations
  class SubscribeToSubreddit < BaseMutation
    argument :subreddit_id, ID, required: true

    type Types::SubredditType

    def resolve(subreddit_id:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authorized" unless user

      subreddit = Subreddit.find(subreddit_id)
      Subscription.find_or_create_by!(user: user, subreddit: subreddit)
      subreddit
    end
  end
end
