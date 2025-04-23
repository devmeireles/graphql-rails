class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subreddit, null: false, foreign_key: true
      t.timestamps
    end

    add_index :subscriptions, [ :user_id, :subreddit_id ], unique: true
  end
end
