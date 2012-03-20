class Course < ActiveRecord::Base
	before_save :fix_ckeditor_attachment_paths
belongs_to :course_type,:foreign_key => "type_id"
 belongs_to :page_temp

  def fix_ckeditor_attachment_paths
    if self.desc.index(/_cke_saved_href/)
      self.desc = self.desc.gsub(/_cke_saved_href/, 'href')
    end
  end
end
