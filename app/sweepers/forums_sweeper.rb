class ForumsSweeper < ActionController::Caching::Sweeper  
  observe Forum # This sweeper is going to keep an eye on the Post model  
  
  # If our sweeper detects that a Post was created call this  
  def after_create(post)  
    expire_cache_for(post)  
  end  
  
  # If our sweeper detects that a Post was updated call this  
  def after_update(post)  
    expire_cache_for(post)  
  end  
  
  # If our sweeper detects that a Post was deletedcall this  
  def after_destroy(post)  
    expire_cache_for(post)  
  end  
  
  private  
  def expire_cache_for(record)  
    # Expire the list page now that we posted a new blog entry  
    expire_page(:controller => 'homes', :action => 'index')  
  

    expire_page("/homes/forums/#{record.id}")  

    cache_dir = ActionController::Base.page_cache_directory
      FileUtils.rm_r(Dir.glob(cache_dir+"/homes/forums/#{record.id}/")) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Cache directory cache_dir/homes/forums/#{record.id}/ fully sweeped.")

  end  
end 