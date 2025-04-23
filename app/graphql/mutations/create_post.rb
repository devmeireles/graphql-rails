module Mutations
  class CreatePost < BaseMutation
    argument :title, String, required: true
    argument :body, String, required: false
    argument :image_url, String, required: false
    argument :subreddit_id, ID, required: true

    type Types::PostType

    def resolve(title:, body: nil, image_url: nil, subreddit_id:)
      user = context[:current_user]
      raise GraphQL::ExecutionError, "Not authorized" unless user

      Post.create!(
        title: title,
        body: body,
        image_url: image_url,
        subreddit_id: subreddit_id,
        author: user
      )
    end
  end
end
