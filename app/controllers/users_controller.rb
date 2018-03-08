class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
   before_action :admin_user,     only: [:destroy, :index]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user =User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        log_in @user
        #format.json { render :show, status: :created, location: @user }
        flash[:success] = "Welcome to the Roland-Garros Tournament Bracket!"
        redirect_to @user
      else
        render 'new'
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    #respond_to do |format|
      if @user.update_attributes(user_params)
          flash[:success] = "Your Profile has been Updated"
          redirect_to @user
        #format.html { redirect_to @user, notice: 'User was successfully updated.' }
        #format.json { render :show, status: :ok, location: @user }
      else
        render 'edit'
        #format.html { render :edit }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    #end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
    flash[:success] = "Account has been successfully deleted"
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :lastname, :firstname, :address, :username)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
     @user = User.find(params[:id])
     redirect_to(root_url) unless @user == current_user
   end
   # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
