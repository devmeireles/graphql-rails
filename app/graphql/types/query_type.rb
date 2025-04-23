module Types
  class QueryType < Types::BaseObject
    # Fetch all posts (optionally paginated)
    field :posts, [ PostType ], null: false do
      argument :limit, Integer, required: false
      argument :offset, Integer, required: false
    end

    def posts(limit: 20, offset: 0)
      Post.order(created_at: :desc).limit(limit).offset(offset)
    end

    # Fetch a single post
    field :post, PostType, null: true do
      argument :id, ID, required: true
    end

    def post(id:)
      Post.find_by(id: id)
    end

    # Fetch all subreddits
    field :subreddits, [ SubredditType ], null: false

    def subreddits
      Subreddit.all.order(name: :asc)
    end

    # Fetch a single subreddit
    field :subreddit, SubredditType, null: true do
      argument :id, ID, required: true
    end

    def subreddit(id:)
      Subreddit.find_by(id: id)
    end

    # Fetch comments for a specific post
    field :comments_for_post, [ CommentType ], null: false do
      argument :post_id, ID, required: true
    end

    def comments_for_post(post_id:)
      Comment.where(post_id: post_id, parent_comment_id: nil).order(created_at: :asc)
    end

    # Authenticated user
    field :me, UserType, null: true

    def me
      context[:current_user]
    end
  end
end
