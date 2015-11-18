class NewCdsController < ApplicationController
  def index
    @new_cds = NewCd.all
  end

  def show
    @new_cd = NewCd.find(params[:id])
  end

  def new
    @new_cd = NewCd.new
    

  end

  def create

   @new_cd = NewCd.new(newcd_params)
   @new_cd.user = current_user
   

     if @new_cd.save
       redirect_to cds_path
     else
       flash[:error] = "There was an error saving the New Cd. Please try again."
       render :new
     end
  end

 def edit
   
   if current_user
      @newcd = NewCd.find(current_user) 
   else
      @newcd = NewCd.find(session[:guest_user_id])
   end

 end


 def update
   if current_user
     @newcd = NewCd.find(current_user)       
     if @newcd.update_attributes(newcd_params)
      
       redirect_to transaction_path(current_user)
     else
       flash[:error] = "Error saving cd. Please try again."
       render :edit
     end
   else
     @newcd = NewCd.find(session[:guest_user_id])
     if @newcd.update_attributes(newcd_params)

       redirect_to transaction_path(session[:guest_user_id])
     else
       flash[:error] = "Error saving cd. Please try again."
       render :edit
     end
   end
 end

 private

   def newcd_params
    params.require(:new_cd).permit(:new_rate, :new_fee, :new_term, :new_bankname)
   end

 end
