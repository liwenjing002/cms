# encoding: utf-8
class AddsController < ApplicationController
  # GET /adds
  # GET /adds.xml
   layout "admin"
  def index
    @adds = Add.paginate :page => params[:page]||1,
                            :per_page=>10,
                            :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adds }
    end
  end

  # GET /adds/1
  # GET /adds/1.xml
  def show
    @add = Add.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @add }
    end
  end

  # GET /adds/new
  # GET /adds/new.xml
  def new
    @add = Add.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @add }
    end
  end

  # GET /adds/1/edit
  def edit
    @add = Add.find(params[:id])
  end

  # POST /adds
  # POST /adds.xml
  def create
    @add = Add.new(params[:add])
pic =  Ckeditor::Picture.create(
      :data  => params[:picture]
    )
    @add.picture_id = pic.id
    respond_to do |format|
      if @add.save
        format.html { redirect_to(@add, :notice => 'Add was successfully created.') }
        format.xml  { render :xml => @add, :status => :created, :location => @add }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @add.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adds/1
  # PUT /adds/1.xml
  def update
    @add = Add.find(params[:id])
	if params[:picture]
	pic =  Ckeditor::Picture.create(
      :data  => params[:picture]
    )
	params[:add][:pic_id] = pic.id
	end
    respond_to do |format|
      if @add.update_attributes(params[:add])
        format.html { redirect_to(@add, :notice => 'Add was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @add.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adds/1
  # DELETE /adds/1.xml
  def destroy
    @add = Add.find(params[:id])
    @add.destroy

    respond_to do |format|
      format.html { redirect_to(adds_url) }
      format.xml  { head :ok }
    end
  end
end
