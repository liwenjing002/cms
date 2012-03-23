class AdminController < ApplicationController
  def dashboard
    render "dashboard",:layout=>"admin"
  end

  def delete_cache
  expire_page(:controller => 'homes', :action => 'index')  
 cache_dir = ActionController::Base.page_cache_directory
      FileUtils.rm_r(Dir.glob(cache_dir+"/homes/")) rescue Errno::ENOENT
      RAILS_DEFAULT_LOGGER.info("Cache directory cache_dir/homes/ fully sweeped.")
      respond_to do |format|
      if request.xhr?  
      format.js
    else
      format.html # index.html.erb
    end
    end
      
end

end
