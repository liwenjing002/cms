class FriendLinksController < ApplicationController
  # GET /friend_links
  # GET /friend_links.xml
    layout "admin"
  def index
    @friend_links = FriendLink.paginate :page => params[:page]||1,
                            :per_page=>10,
							:conditions=>["name like ?",params[:name]? "%#{params[:name]}%":"%"],
                            :order => 'updated_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @friend_links }
    end
  end

  # GET /friend_links/1
  # GET /friend_links/1.xml
  def show
    @friend_link = FriendLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @friend_link }
    end
  end

  # GET /friend_links/new
  # GET /friend_links/new.xml
  def new
    @friend_link = FriendLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @friend_link }
    end
  end

  # GET /friend_links/1/edit
  def edit
    @friend_link = FriendLink.find(params[:id])
  end

  # POST /friend_links
  # POST /friend_links.xml
  def create
    @friend_link = FriendLink.new(params[:friend_link])

    respond_to do |format|
      if @friend_link.save
        format.html { redirect_to(@friend_link, :notice => 'Friend link was successfully created.') }
        format.xml  { render :xml => @friend_link, :status => :created, :location => @friend_link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @friend_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /friend_links/1
  # PUT /friend_links/1.xml
  def update
    @friend_link = FriendLink.find(params[:id])

    respond_to do |format|
      if @friend_link.update_attributes(params[:friend_link])
        format.html { redirect_to(@friend_link, :notice => 'Friend link was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @friend_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /friend_links/1
  # DELETE /friend_links/1.xml
  def destroy
    @friend_link = FriendLink.find(params[:id])
    @friend_link.destroy

    respond_to do |format|
      format.html { redirect_to(friend_links_url) }
      format.xml  { head :ok }
    end
  end
end
