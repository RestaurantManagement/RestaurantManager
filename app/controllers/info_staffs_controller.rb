class InfoStaffsController < ApplicationController
  before_action :set_info_staff, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create]
  before_action :admin_user, only: [:new, :newByStaff, :create, :edit, :update, :destroy]
  
  def index
    @info_staffs = InfoStaff.all
  end

  
  def show
  end

  
  def new
    @info_staffs = InfoStaff.new
  end

  
  def newByStaff
    @info_staff = InfoStaff.new
    @info_staff.Staff_id = params[:id]
  end
  # GET /menu_items/1/edit
  def edit
  end

  
  def create
    @info_staff = InfoStaff.new(info_staff_params)

    respond_to do |format|
      if @info_staff.save
        format.html { redirect_to staffs_url, notice: 'a staff was successfully created.' }
        format.json { render :show, status: :created, location: @info_staff }
      else
        format.html { render :new }
        format.json { render json: @info_staff.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update

    if @info_staff.update(info_staff_params)
      flash[:success] = 'profile was successfully updated.'
      redirect_back_or staffs_url
    else
      format.html { render :edit }
      format.json { render json: @info_staff.errors, status: :unprocessable_entity }
    end
    
  end

 
  def destroy
    binding.pry
    @info_staff.destroy
    flash[:success] = 'profile was successfully destroyed.'
    redirect_to list_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_info_staff
      @info_staff = InfoStaff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def info_staff_params
      params.require(:info_staff).permit(:name, :age, :description,:nation, :Staff_id, :image)
    end
end
