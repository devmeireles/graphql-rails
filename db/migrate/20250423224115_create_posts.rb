class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body
      t.string :image_url
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :subreddit, null: false, foreign_key: true
      t.timestamps
    end
  end
end
