class AdminController < ApplicationController
  def dashboard
    render "dashboard",:layout=>"admin"
  end

  def delete_cache
  expire_page(:controller => 'homes', :action => 'index')  
 cache_dir = ActionController::Base.page_cache_directory
      FileUtils.rm_r(Dir.glob(cache_dir+"/homes/")) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Cache directory cache_dir/homes/ fully sweeped.")
  redirect_to articles_path, :alert => "Watch it, mister!"
      
end

end
