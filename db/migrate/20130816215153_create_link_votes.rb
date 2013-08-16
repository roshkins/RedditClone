class CreateLinkVotes < ActiveRecord::Migration
  def change
    create_table :link_votes do |t|
      t.integer :link_id, :null => false
      t.integer :user_id, :null => false
      t.boolean :upvote,  :null => false

      t.timestamps
    end
    add_index :link_votes, :link_id
    add_index :link_votes, :user_id
    add_index :link_votes, [:link_id, :user_id], :unique => true
  end
end
