class AdminController < ApplicationController
  def dashboard
    render "dashboard",:layout=>"admin"
  end

end
