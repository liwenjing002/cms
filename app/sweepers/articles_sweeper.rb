class ArticlesSweeper < ActionController::Caching::Sweeper  
  observe Article # This sweeper is going to keep an eye on the Post model  
  
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
  
    # Also expire the show page, in case we just edit a  blog entry  
    expire_page(:controller => 'homes', :action => 'forums')  
  end  
end 