class TempOrdersController < ApplicationController
  before_action :set_temp_order, only: [:show, :edit, :update, :destroy, :clear]
  #access controls
  before_action :logged_in_user, except: []
  before_action :correct_user_or_admin, only: [:show, :edit, :update, :destroy, :clear]
  before_action :correct_user,   only: [:newByUser]
  # GET /temp_orders
  # GET /temp_orders.json
  def index
    @temp_orders = TempOrder.all
  end

  # GET /temp_orders/1
  # GET /temp_orders/1.json
  def show
  end

  # GET /temp_orders/new
  def new
    @temp_order = TempOrder.new
  end

  # GET /users/:id/temp_order
  def newByUser
    @temp_order = TempOrder.find_by(user_id: params[:id])
    tables = Table.all
    @tables = []

    tables.each_with_index do |item, index|
      @tables.push([item.no, item.id])
    end

    unless @temp_order 
      @temp_order = TempOrder.new
      @temp_order.user_id = params[:id]
      @form = { path: temp_orders_path, method: :post }   
    else
      @form = { path: "/temp_orders/#{@temp_order.id}", method: :patch }
    end

    @temp_order_items = @temp_order.temp_order_items

    current_table = @temp_order.table
    @current_table = nil
    if current_table
      @current_table = [current_table.no, current_table.id]
    end

  end

  # GET /temp_orders/1/edit
  def edit
  end

  # POST /temp_orders
  # POST /temp_orders.json
  def create
    @temp_order = TempOrder.new(temp_order_params)

    if params[:create_or_update]
      if @temp_order.save
        flash[:success] = "Succeed create your pre-order."
      else
        flash[:danger] = "Got error when created your pre-order."
      end
      redirect_to new_temp_order_by_user_path(current_user)  
    elsif @temp_order.save
      submit
    else 
      flash[:danger] = "Got error when book table."
      redirect_to new_temp_order_by_user_path(current_user)
    end
  end

  # PATCH/PUT /temp_orders/1
  # PATCH/PUT /temp_orders/1.json
  def update
    if params[:create_or_update]  
      if @temp_order.update(temp_order_params)
        flash[:success] = "Succeed update your pre-order."
      else
        flash[:danger] = "Got error when updated your pre-order."
      end
      redirect_to new_temp_order_by_user_path(current_user)
    elsif @temp_order.update(temp_order_params)
      submit
    else
      flash[:danger] = "Got error when update pre-order"
      redirect_to new_temp_order_by_user_path(current_user)
    end
  end

  # DELETE /temp_orders/1
  # DELETE /temp_orders/1.json
  def destroy
    @temp_order.destroy
    respond_to do |format|
      format.html { redirect_to temp_orders_url, notice: 'Temp order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # DELETE /temp_orders/:id/clear
  def clear
    if @temp_order.destroy!
      flash[:success] = "Cleared your pre-order."
    else
      flash[:danger] = "Failed to clear your pre-order."
    end 
    redirect_to new_temp_order_by_user_path(current_user)
  end  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_order
      @temp_order = TempOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def temp_order_params
      params.require(:temp_order).permit(:user_id, :table_id, :book_time,
                                          temp_order_items_attributes: [
                                            :id, :menu_item_id, :quantity, :temp_order_id] )
    end

    # Confirms the correct user.
    def correct_user
      user = User.find(params[:id])
      unless current_user?(user) 
        flash[:danger] = "Uncorrect user."
        redirect_to(root_url) 
      end
    end

    # Confirms the correct user of temp_order
    def correct_user_or_admin
      user = TempOrder.find(params[:id]).user
      unless current_user?(user) || admin_user?
        flash[:danger] = "Uncorrect user."
        redirect_to root_url
      end
    end

    def submit
      order = Order.clone_temp(@temp_order)
      if !order
        flash[:danger] = "Got error when submitted your order."
      elsif @temp_order.destroy!
        flash[:success] = "Submitted your order."
      else
        flash[:danger] = "Submitted your order but get error when clear pre-order."
      end
      redirect_to new_temp_order_by_user_path(current_user)
    end

end
