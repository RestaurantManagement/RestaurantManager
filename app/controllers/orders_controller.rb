class OrdersController < ApplicationController
  #access controls
  before_action :set_order, only: [:show, :detail_order, :edit, :update, :destroy, :pay]
  before_action :logged_in_user, except: []
  before_action :order_of_correct_user_or_admin, only: [:show, :detail_order, 
                                                        :edit, :update, :destroy]
  before_action :correct_user_or_admin, only: [:submittedOrder]
  before_action :admin_user, only: [:index, :tableOrders]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.paginate(page: params[:page], per_page: 20)
              .order(paid: :asc, created_at: :desc)
  end

  # GET /users/:id/orders    (:id is userId)
  def submittedOrder
    @orders = Order.where(user_id: params[:id]).paginate(page: params[:page], per_page: 20)
                                                .order(paid: :asc, created_at: :desc)
  end

  # GET /tables/:id/orders
  def tableOrders
    @orders = Order.where(table_id: params[:id]).paginate(page: params[:page], per_page: 20)
                                                .order(paid: :asc, created_at: :desc)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /users/:uid/orders/:id
  def detail_order
  end

  # POST /orders/:id/pay
  def pay 
    admin?(params[:user_id])
    @order.paid = true
    if @order.save
      render json: {status: "OK"}.to_json 
    else 
      render json: {status: "pay failed."}.to_json, status: 404 
    end
  end

  # GET /orders/new   #disabled
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :table_id, :book_time)
    end

    # Confirms the correct user of order
    def order_of_correct_user_or_admin
      user = Order.find(params[:id]).user
      unless current_user?(user) || admin_user?
        flash[:danger] = "Uncorrect user."
        redirect_to root_url
      end
    end

    # Confirms the correct user
    def correct_user_or_admin
      user = User.find(params[:id])
      unless current_user?(user) || admin_user?
        flash[:danger] = "Uncorrect user."
        redirect_to root_url
      end
    end

    def admin?(id)
      user = User.find(id)
      unless user.admin
        flash[:danger] = "You're not allowed to do this action."
        redirect_to root_url
      end
    end
end
