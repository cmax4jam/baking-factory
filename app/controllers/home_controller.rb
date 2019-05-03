class HomeController < ApplicationController

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
    @medicines = Medicine.search_full_text(@query)
    @procedures = []
    @total_hits = @owners.size + @pets.size + @medicines.size + @procedures.size

  end

end