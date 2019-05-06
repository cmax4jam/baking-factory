class ItemPricesController < ApplicationController
    before_action :check_login
    authorize_resource

    def new
        @item_price = ItemPrice.new
        @item = Item.find(params[:item_id])
    end

    def create
        @item_price = ItemPrice.new(item_price_params)
        @item_price.start_date = Date.current
        if @item_price.save
            redirect_to item_path(@item_price.item), notice: "A new price of #{ActiveSupport::NumberHelper.number_to_currency(@item_price.price)} was set for #{@item_price.item.name}."
        else
            @item = Item.find(params[:item_price][:item_id])
            render action: 'new'
        end
    end

    def item_price_params
        params.require(:item_price).permit(:item_id, :price, :start_date, :end_date)
    end

end