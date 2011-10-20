class AddPicArticle < ActiveRecord::Migration
  def self.up
  add_column :articles,:picture_id,:integer
  end

  def self.down
  remove_column :articles,:picture_id
  end
end
