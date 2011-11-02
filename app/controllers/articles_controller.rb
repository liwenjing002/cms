class ArticlesController < ApplicationController
  layout "admin"
  def index
    @articles = Article.paginate :page => params[:page]||1,
                            :per_page=>10,
							:conditions=>["title like ?",params[:title]? "%#{params[:title]}%":"%"],
                            :order => 'created_at DESC'
                          
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    params[:article][:user_id]= session[:user_id]
    if params[:article]
    @article = Article.new(params[:article])
   pic =  Ckeditor::Picture.create(
      :data  => params[:picture]
    )
    @article.picture_id = pic.id
    end
    respond_to do |format|
      if @article.save
        format.html { redirect_to(@article, :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])
	pic =  Ckeditor::Picture.create(
      :data  => params[:picture]
    )
	params[:article][:picture_id] = pic.id
    respond_to do |format|
      params[:article][:user_id]= session[:user_id]
      if @article.update_attributes(params[:article])
        format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end
  
  
end
