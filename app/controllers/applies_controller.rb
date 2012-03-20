class AppliesController < ApplicationController
  # GET /applies
  # GET /applies.xml
  layout "admin"
  def index
    @applies = Apply.paginate :page => params[:page]||1,
                            :per_page=>10,
              :conditions=>["name like ?",params[:name]? "%#{params[:name]}%":"%"],
                            :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @applies }
    end
  end

  # GET /applies/1
  # GET /applies/1.xml
  def show
    @apply = Apply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apply }
    end
  end

  # GET /applies/new
  # GET /applies/new.xml
  def new
    @apply = Apply.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @apply }
    end
  end

  # GET /applies/1/edit
  def edit
    @apply = Apply.find(params[:id])
  end

  # POST /applies
  # POST /applies.xml
  def create
    @apply = Apply.new(params[:apply])

    respond_to do |format|
      if @apply.save
        format.html { redirect_to(@apply, :notice => 'Apply was successfully created.') }
        format.xml  { render :xml => @apply, :status => :created, :location => @apply }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @apply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /applies/1
  # PUT /applies/1.xml
  def update
    @apply = Apply.find(params[:id])

    respond_to do |format|
      if @apply.update_attributes(params[:apply])
        format.html { redirect_to(@apply, :notice => 'Apply was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @apply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /applies/1
  # DELETE /applies/1.xml
  def destroy
    @apply = Apply.find(params[:id])
    @apply.destroy

    respond_to do |format|
      format.html { redirect_to(applies_url) }
      format.xml  { head :ok }
    end
  end
end
