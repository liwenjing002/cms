class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.text :context
      t.integer :user_id
      t.integer :read_num
      t.integer :modi_user
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
