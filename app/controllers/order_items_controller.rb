class OrderItemsController < ApplicationController
    authorize_resource 
    
    def toggle_shipped
        @oitem = OrderItem.find(params[:order_item_id])
        if @oitem.update(shipped_on: @oitem.shipped_on.nil? ? Date.today : nil)
          redirect_back(fallback_location: shipper_home_path, notice: "Order Item for customer, #{@oitem.order.customer.proper_name}, was made #{@oitem.shipped_on.nil? ? "unshipped" : "shipped"}")
        else
          redirect_back(fallback_location: shipper_home_path, alert: @oitem.errors[:base].first)
        end
      end

    def order_item_params
        params.require(:order_item).permit(:order_id, :item_id, :quantity, :shipped_on)
    end

end