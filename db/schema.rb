# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_23_224207) do
  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.integer "author_id", null: false
    t.integer "post_id", null: false
    t.integer "parent_comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["parent_comment_id"], name: "index_comments_on_parent_comment_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.string "image_url"
    t.integer "author_id", null: false
    t.integer "subreddit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["subreddit_id"], name: "index_posts_on_subreddit_id"
  end

  create_table "subreddits", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_subreddits_on_creator_id"
    t.index ["name"], name: "index_subreddits_on_name", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "subreddit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subreddit_id"], name: "index_subscriptions_on_subreddit_id"
    t.index ["user_id", "subreddit_id"], name: "index_subscriptions_on_user_id_and_subreddit_id", unique: true
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer "value", null: false
    t.integer "user_id", null: false
    t.integer "post_id"
    t.integer "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_votes_on_comment_id"
    t.index ["post_id"], name: "index_votes_on_post_id"
    t.index ["user_id", "comment_id"], name: "index_votes_on_user_id_and_comment_id", unique: true, where: "comment_id IS NOT NULL"
    t.index ["user_id", "post_id"], name: "index_votes_on_user_id_and_post_id", unique: true, where: "post_id IS NOT NULL"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "blogs", "users"
  add_foreign_key "comments", "comments", column: "parent_comment_id"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "posts", "subreddits"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "subreddits", "users", column: "creator_id"
  add_foreign_key "subscriptions", "subreddits"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "votes", "comments"
  add_foreign_key "votes", "posts"
  add_foreign_key "votes", "users"
end
