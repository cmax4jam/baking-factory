class SessionsController < ApplicationController
    include AppHelpers::Cart

    def new
    end

    def create
      user = User.find_by_username(params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        if current_user.role?(:admin)
          redirect_to admin_insights_path, notice: "Logged in!"
        elsif current_user.role?(:customer)
          create_cart
          redirect_to customer_home_path, notice: "Logged in!"
        elsif current_user.role?(:baker)
          redirect_to baker_home_path, notice: "Logged in!"
        elsif current_user.role?(:shipper)
          redirect_to shipper_home_path, notice: "Logged in!"
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
      destroy_cart
      redirect_to home_path, notice: "Logged out!"
    end


end