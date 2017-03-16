class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create]
  before_action :admin_user, only: [:new, :newByCategory, :create, :edit, :update, :destroy]
  # GET /menu_items
  # GET /menu_items.json
  def index
    @menu_items = MenuItem.all
  end

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new
  end

  # GET /menu_items/:id/edit
  def newByCategory
    @menu_item = MenuItem.new
    @menu_item.category_id = params[:id]
  end
  # GET /menu_items/1/edit
  def edit
  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    @menu_item = MenuItem.new(menu_item_params)

    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to categories_url, notice: 'Menu item was successfully created.' }
        format.json { render :show, status: :created, location: @menu_item }
      else
        format.html { render :new }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_items/1
  # PATCH/PUT /menu_items/1.json
  def update

    if @menu_item.update(menu_item_params)
      flash[:success] = 'Menu item was successfully updated.'
      redirect_back_or categories_url
    else
      format.html { render :edit }
      format.json { render json: @menu_item.errors, status: :unprocessable_entity }
    end
    
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    @menu_item.destroy
    flash[:success] = 'Menu item was successfully destroyed.'
    redirect_back_or categories_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :price, :description, :category_id, :image)
    end
end
