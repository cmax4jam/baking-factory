class SessionsController < ApplicationController
    include AppHelpers::Cart

    def new
    end

    def create
      user = User.find_by_username(params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        create_cart
        if current_user.role == 'admin'
          redirect_to admin_insights_path, notice: "Logged in!"
        elsif current_user.role == 'customer'
          redirect_to customer_home_path, notice: "Logged in!"
        else
          redirect_to home_path, notice: "Logged in!"
        end
      else
        flash.now.alert = "Email or password is invalid"
        render "new"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to home_path, notice: "Logged out!"
    end


    def add_to_cart(item_id)
      add_item_to_cart(item_id)
    end

    def remove_from_cart(item_id)
      remove_item_from_cart(item_id)
    end

    def get_cart_size
      get_list_of_items_in_cart().size
    end
end