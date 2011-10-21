class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end
     User.create({:name=>"huanbao",:password=>"huanbao",:password_comfire=>"huanbao",:email=>"liwenjingabc@126.com"})
  end

  def self.down
    drop_table :users
  end
end
