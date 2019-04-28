class UsersController < ApplicationController
    before_action :current_user, only: [:edit, :update]
    before_action :check_login, except: [:index, :show]

    authorize_resource
  
    def new
      @user = User.new
    end
  
    def edit
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        session[:user_id] = @user.id
        redirect_to(home_path, :notice => 'User was successfuly created.')
      else
        render :action => 'new'
      end
    end

    def update
      if @user.update_attributes(current_user)
        redirect_to(@user, :notice => 'User was successfully updated.')
      else
        render :action => "edit"
      end
    end

    def destroy
      @user.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
    #   def current_user
    #     @user = User.find(params[:id])
    #   end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :active, :role)    
      end
end
  