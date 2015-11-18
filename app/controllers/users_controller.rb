class UsersController < ApplicationController
  def index
    @users = User.search(params[:search])
  end

  def update
     @user = User.find(session[:guest_user_id])       
      if @user.update_attributes(user_params)
     
          redirect_to edit_transaction_path(@user)
      else
          flash[:error] = "Error saving topic. Please try again."
          render :edit
      end
  end

  private

  def user_params
    params.require(:user).permit(:name)
   end

end