class CreateFriendLinks < ActiveRecord::Migration
  def self.up
    create_table :friend_links do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :friend_links
  end
end
