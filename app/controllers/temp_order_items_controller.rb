class TempOrderItemsController < ApplicationController
  before_action :set_temp_order_item, only: [:destroy]
  #access controls
  before_action :logged_in_user, only: [:create]
  before_action :correct_or_admin_user,   only: [:destroy]
  
  # POST /temp_order_items
  # POST /temp_order_items.json
  def create
    pr = order_item_params
    cu = current_user
    to = cu.temp_order

    unless to 
      tb = Table.first
      to = TempOrder.create(user_id: cu.id, table_id: tb.id, book_time: Time.now)
      item = TempOrderItem.new(menu_item_id: pr[:menu_item_id], quantity: 1, temp_order_id: to.id)
    else
      item = TempOrderItem.find_by(menu_item_id: pr[:menu_item_id], temp_order_id: to.id)
      if item
        item.quantity += 1
      else
        item = TempOrderItem.new(menu_item_id: pr[:menu_item_id], quantity: 1, temp_order_id: to.id)
      end
    end

    if item.save
      flash[:success] = "Ordered item #{pr[:menu_item_name]} successfully."
    else
      flash[:danger] = "Failed when Ordered item #{pr[:menu_item_name]}."
    end

    redirect_to pr[:path]
  end

  # DELETE /temp_order_items/1
  # DELETE /temp_order_items/1.json
  def destroy
    @temp_order_item.destroy
    redirect_to new_temp_order_by_user_path(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_order_item
      @temp_order_item = TempOrderItem.find(params[:id])
    end

    # Confirms the correct user.
    def correct_or_admin_user
      @user = @temp_order_item.temp_order.user
      unless current_user?(@user) || admin_user?
        flash[:danger] = "Uncorrect user."
        redirect_to(root_url) 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:menu_item_id, :menu_item_name, :path)
    end

end
