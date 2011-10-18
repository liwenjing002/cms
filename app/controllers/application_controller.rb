class ApplicationController < ActionController::Base
  protect_from_forgery
  def redirect_back_or_default default
    if session[:return_to] &&
        session[:return_to] != "/" &&
        session[:return_to] != "#{request.request_uri}" &&
        !session[:return_to].include?( request.path)
      redirect_to(session[:return_to])
      session[:return_to] = nil
      return
    else
      redirect_to(default)
      return
    end
  end

  def is_login
    if session[:is_login]==nil &&request.request_uri!= "/user/login"&&
        request.parameters[:controller] != "home" && session[:return_to] != "/"&&
        request.parameters[:controller] !='user'&&
        request.parameters[:action]!= "connect_us"
      session[:return_to] = request.request_uri
      redirect_to :controller=>"user",:action=>"login"
    end
  end
end
