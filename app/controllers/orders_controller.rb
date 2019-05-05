class OrdersController < ApplicationController
  include AppHelpers::Cart
  include AppHelpers::Shipping

  before_action :set_order, only: [:show, :edit, :destroy]
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

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.date = Date.current
    @order.grand_total = calculate_cart_items_cost + calculate_cart_shipping
    @order.customer = current_user.customer
    @order.expiration_year = @order.expiration_year.to_i
    @order.expiration_month = @order.expiration_month.to_i
    if @order.save
      save_each_item_in_cart(@order)
      @order.pay
      clear_cart
      redirect_to @order, notice: "Thank you for ordering from the Baking Factory."
    else
      render action: 'new'
    end
  end

  def add_to_cart
    add_item_to_cart(params[:item_id])
    redirect_back(fallback_location: items_path, notice: "Item added to cart")
  end

  def remove_from_cart
    remove_item_from_cart(params[:item_id])
    redirect_back(fallback_location: new_order_path, notice: "Item removed from cart.")
  end
  

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:address_id, :customer_id, :grand_total, :item_id, :credit_card_number, :expiration_year, :expiration_month)
  end

end