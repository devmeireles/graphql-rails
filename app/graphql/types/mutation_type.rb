# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_post, mutation: Mutations::CreatePost
    field :vote_post, mutation: Mutations::VotePost
    field :create_comment, mutation: Mutations::CreateComment
    field :vote_comment, mutation: Mutations::VoteComment
    field :subscribe_to_subreddit, mutation: Mutations::SubscribeToSubreddit
  end
end
