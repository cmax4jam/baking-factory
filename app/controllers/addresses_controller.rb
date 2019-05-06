class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource
  
  def index
    if logged_in? && current_user.role?(:customer)
      @active_addresses = current_user.customer.addresses.by_recipient.paginate(:page => params[:page]).per_page(10)
      @inactive_addresses = current_user.customer.addresses.inactive.by_recipient.paginate(:page => params[:page]).per_page(10)
    else
      @active_addresses = Address.active.by_customer.by_recipient.paginate(:page => params[:page]).per_page(10)
      @inactive_addresses = Address.inactive.by_customer.by_recipient.paginate(:page => params[:page]).per_page(10)
      @all_customers = Customer.active.alphabetical
    end
    
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    if current_user.role?(:customer)
      @address.customer = current_user.customer
    end
    @address.active = true
    
    if @address.save
      redirect_to addresses_path, notice: "The address was added to #{@address.customer.proper_name}."
    else
      render action: 'new'
    end
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path, notice: "The address was revised in the system."
    else
      render action: 'edit'
    end
  end

  def toggle_address_state
    @address = Address.find(params[:address_id])
    if @address.update(active: !@address.active)
      redirect_back(fallback_location: addresses_path, notice: "Address for customer, #{@address.customer.proper_name}, was made #{@address.active ? "Active" : "Inactive"}")
    else
      redirect_back(fallback_location: addresses_path, alert: @address.errors[:base].first)
    end
  end


  private
  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:customer_id, :recipient, :street_1, :street_2, :city, :state, :zip, :active, :is_billing, :customer_id)
  end

end