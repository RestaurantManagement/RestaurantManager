class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #access controls
  before_action :logged_in_user, only: [:index, :show]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user,     only: [:index, :destroy]
  # GET /users
  # GET /users.json
  def index
    if params[:email]
      @users = User.matching(:email, params[:email]).paginate(page: params[:page])
    else
      @users = User.paginate(page: params[:page])
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

  
    if @user.save
      log_in @user
      flash[:success] = 'User was successfully created.'
      redirect_back_or @user    
    else
      render :new 
    end
    
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) || admin_user?
        flash[:danger] = "You're not allowed to do this action."
        redirect_to(root_url) 
      end
    end

end
