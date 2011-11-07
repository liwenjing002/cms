# Use this hook to configure ckeditor
if Object.const_defined?("Ckeditor")
  Ckeditor.setup do |config|
    # ==> ORM configuration
    # Load and configure the ORM. Supports :active_record (default), :mongo_mapper and
    # :mongoid (bson_ext recommended) by default. Other ORMs may be
    # available as additional gems.
    require "ckeditor/orm/active_record"

    # Allowed image file types for upload.
    # Set to nil or [] (empty array) for all file types
    # config.image_file_types = ["jpg", "jpeg", "png", "gif", "tiff"]

    # Allowed attachment file types for upload.
    # Set to nil or [] (empty array) for all file types
    # config.attachment_file_types = ["doc", "docx", "xls", "odt", "ods", "pdf", "rar", "zip", "tar", "swf"]
    
    # Ckeditor files destination path (default 'public/javascripts')
    config.path = 'public/javascripts'
  end
end

PAPERCLIP_PHOTO_OPTIONS = {
# :s3_credentials => "#{Rails.root}/config/s3.yml", :bucket => "huanbao",
 #:storage => :s3,
 #  :url  => "/ckeditor_assets/pictures/:id/:style_:basename.:extension",
#:path          => "/images/public/system/:rails_env/:class/:attachment/:id/:style/:fingerprint.:extension", 
	:url  => "/ckeditor_assets/pictures/:id/:style_:basename.:extension",
    :path => ":rails_root/public/ckeditor_assets/pictures/:id/:style_:basename.:extension",
	:styles => { :content => '800>', :thumb => '118x100#' },
  :default_url   => "/images/missing_:style.png"
}
