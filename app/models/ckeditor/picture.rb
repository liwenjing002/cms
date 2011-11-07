class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    PAPERCLIP_PHOTO_OPTIONS
	
	validates_attachment_size :data, :less_than => 2.megabytes
	validates_attachment_presence :data
	
	def url_content
	  url(:content)
	end
end
