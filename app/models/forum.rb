class Forum < ActiveRecord::Base
validates_presence_of :name,:message => "版块名称不为空"
validates_uniqueness_of :name,:message => "版块名称已经被使用"
 belongs_to :father,:class_name =>"Forum"

end
