# encoding: utf-8
class Add < ActiveRecord::Base
  validates_presence_of :name,:message => "名称不为�?
validates_presence_of :url,:message => "广告链接不为�?
  belongs_to :picture,:class_name=>"Ckeditor::Picture"
end
