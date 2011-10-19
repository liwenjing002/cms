class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  layout "admin"
  
  def index
    @users = User.paginate :page => params[:page]||1,
                            :per_page=>10,
							:conditions=>["name like ?",params[:name]? "%#{params[:name]}%":"%"],
                            :order => 'created_at DESC'
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def login
    @user = User.new(params[:user])
   if !request.post?
   render "login",:layout=>"login"
   return 
    end
    if @user.login(session)
      flash[:notice] = "Hello! #{@user.name},"+ I18n.t('welcome_word')
      redirect_to "/admin/dashboard"
    else
       @error_msg = "用户名/密码错误"
       render "login",:layout=>"login"
    end
   
  end

  
  
  def logout
    User.logout(session)
    redirect_back_or_default ('/users/login')
  end
  
  def forget_password
    user = User.find_by_email(params[:email])
    if user
      Mailer.delay.deliver_get_password(user)
      flash[:notice] = I18n.t('password_send')
    else
      flash[:notice] = I18n.t('no_email')
    end
    @user = User.new()
    render :action=> "login"
  end
  
end
