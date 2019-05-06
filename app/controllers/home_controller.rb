class HomeController < ApplicationController
  before_action :check_login, only: [:insights, :actions, :baker_home, :shipper_home]
  authorize_resource :class => false, only: [:insights, :actions, :baker_home, :shipper_home]

  def home
  end

  def about
  end

  def privacy
  end

  def contact
  end

  def insights
  end

  def actions
  end

  def customer_home
  end

  def baker_home
    @breads = create_baking_list_for('bread')
    @muffins = create_baking_list_for('muffins')
    @pastries = create_baking_list_for('pastries')
  end

  def shipper_home
    @orders = Order.not_shipped
  end

  def search
    redirect_back(fallback_location: home_path) if params[:query].blank?
    @query = params[:query]
    # Basic search
    @items = Item.search(@query)
    if current_user.role?(:admin)
      @customers = Customers.search(@query)
      @total_hits = @customers.size + @items.size
    else
      @total_hits = @items.size
    end

    # Multisearch
    # @results = PgSearch.multisearch(@query)
    # @total_hits = @results.size

    # Better search
    # @customers = Customer.search_name(@query) + Customer.search(@query)
    # @items = Item.search_name(@query)
    # @total_hits = @customers.size + @items.size

  end

  def create_baking_list_for(category)
    # returns a hash of item name and quantity to be baked for a 
    # particular category of items like bread, muffins, etc.
    #byebug
    all_items = Item.for_category(category).map(&:name).sort
    puts(all_items)
    baking_list = Hash[all_items.map{|name| [name, 0]}]
    puts(baking_list)
    unshipped_items = OrderItem.unshipped.map{|oi| [oi.item.name, oi.quantity] if all_items.include?(oi.item.name)}.compact
    puts(unshipped_items)
    unshipped_items.each{|name, quant| baking_list[name] += quant} unless unshipped_items.nil?
    puts(baking_list)
    baking_list.delete_if{|key, value| value == 0}
    puts(baking_list)
    return baking_list
  end
  helper_method :create_baking_list_for




end