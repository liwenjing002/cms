# encoding: utf-8
class Forum < ActiveRecord::Base
validates_presence_of :name,:message => "版块名称不为空"
validates_uniqueness_of :name,:message => "版块名称已经被使用"
validates_uniqueness_of :code,:message => "版块代号已经被使用"
 belongs_to :father,:class_name =>"Forum"

  has_many :children ,:class_name=>"Forum",:foreign_key=>"father_id", :order => "updated_at desc"
  has_many :articles_father , :class_name=>"Article",:dependent => :destroy,:foreign_key=>"first_forum_id",:conditions => "forum_id is null or forum_id =''", :order => "updated_at desc"
  has_many :articles , :dependent => :destroy

end
