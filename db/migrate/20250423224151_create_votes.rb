class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.integer :value, null: false # -1 or 1
      t.references :user, null: false, foreign_key: true
      t.references :post, foreign_key: true
      t.references :comment, foreign_key: true
      t.timestamps
    end

    add_index :votes, [ :user_id, :post_id ], unique: true, where: "post_id IS NOT NULL"
    add_index :votes, [ :user_id, :comment_id ], unique: true, where: "comment_id IS NOT NULL"
  end
end
