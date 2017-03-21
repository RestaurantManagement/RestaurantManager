class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :staff, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :show]
  before_action :admin_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  # GET /
  # GET /categories.json
  def index
    @staffs = Staff.all
  end

  #get /menu
  def list
    @staffs=  Staff.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    store_location
    @info_staffs = @staff.info_staffs.paginate(page: params[:page])
  end

  #GET /menu/:id
  #Menu by staff
  def  staff
    @info_staffs = @staff.info_staffs.paginate(page: params[:page])
  end
  # GET /categories/new
  def new
    @staff = Staff.new
  end

  # GET /categories/1/edit
  def edit	
  end

  # POST /categories
  # POST /categories.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to @staff, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @staff.update(staff_params)
        format.html { redirect_to @staff, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params.require(:staff).permit(:content, :image)
    end
end
