class CreateSubreddits < ActiveRecord::Migration[8.0]
  def change
    create_table :subreddits do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
