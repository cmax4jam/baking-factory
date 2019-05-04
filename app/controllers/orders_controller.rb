class OrdersController < ApplicationController
  include AppHelpers::Cart

  before_action :set_order, only: [:show, :destroy]
  before_action :check_login
  authorize_resource

  def index
    if current_user.role == 'customer'
      @previous_orders = current_user.customer.orders.chronological.paginate(:page => params[:page]).per_page(10)
    else
      @all_orders = Order.chronological.paginate(:page => params[:page]).per_page(10)
    end
  end

  def show
    @previous_orders = @order.customer.orders.chronological.to_a
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.date = Date.current
    if @order.save
      @order.pay
      redirect_to @order, notice: "Thank you for ordering from the Baking Factory."
    else
      render action: 'new'
    end
  end

  def add_to_cart
    add_item_to_cart(params[:item_id])
    redirect_to items_path, notice: "Item added to cart."
  end

  def remove_from_cart(item_id)
    remove_item_from_cart(item_id)
  end

  def get_cart_size
    get_list_of_items_in_cart().size
  end
  

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:address_id, :customer_id, :grand_total, :item_id)
  end

end