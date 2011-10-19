class AddForumToArticle < ActiveRecord::Migration
  def self.up
  add_column :articles,:first_forum_id,:integer
  add_column :articles,:second_forum_id,:integer
  end

  def self.down
  end
end
