class PageTempsController < ApplicationController
  # GET /page_temps
  # GET /page_temps.xml

  layout "admin"
  def index
    @page_temps = PageTemp.paginate :page => params[:page]||1,
                            :per_page=>10,
              :conditions=>["name like ?",params[:name]? "%#{params[:name]}%":"%"]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page_temps }
    end
  end

  # GET /page_temps/1
  # GET /page_temps/1.xml
  def show
    @page_temp = PageTemp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page_temp }
    end
  end

  # GET /page_temps/new
  # GET /page_temps/new.xml
  def new
    @page_temp = PageTemp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page_temp }
    end
  end

  # GET /page_temps/1/edit
  def edit
    @page_temp = PageTemp.find(params[:id])
  end

  # POST /page_temps
  # POST /page_temps.xml
  def create
    @page_temp = PageTemp.new(params[:page_temp])

    respond_to do |format|
      
      if @page_temp.save
        format.html { redirect_to(@page_temp, :notice => 'Page temp was successfully created.') }
        format.xml  { render :xml => @page_temp, :status => :created, :location => @page_temp }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page_temp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /page_temps/1
  # PUT /page_temps/1.xml
  def update
    @page_temp = PageTemp.find(params[:id])

    respond_to do |format|
      if @page_temp.update_attributes(params[:page_temp])
        format.html { redirect_to(@page_temp, :notice => 'Page temp was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page_temp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /page_temps/1
  # DELETE /page_temps/1.xml
  def destroy
    @page_temp = PageTemp.find(params[:id])
    @page_temp.destroy

    respond_to do |format|
      format.html { redirect_to(page_temps_url) }
      format.xml  { head :ok }
    end
  end
end
