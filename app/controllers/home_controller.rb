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
  end

  def shipper_home
  end

  def search
    redirect_back(fallback_location: home_path) if params[:query].blank?
    @query = params[:query]
    # Basic search
    # @owners = Owner.search(@query)
    # @pets = Pet.search(@query)
    # @total_hits = @owners.size + @pets.size

    # Multisearch
    # @results = PgSearch.multisearch(@query)
    # @total_hits = @results.size

    # Better search
    @customers = Customer.search_name(@query) + Customer.search(@query)
    @items = Item.search_name(@query)
    @total_hits = @customers.size + @items.size

  end

end