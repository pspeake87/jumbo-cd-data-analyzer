class NewCdsController < ApplicationController
  def index
    @new_cds = NewCd.all
  end

  def show
    @new_cd = NewCd.find(params[:id])

    
  end

  def new
    @new_cd = NewCd.new
    authorize @new_cd

  end

  def create

   @new_cd = NewCd.new(newcd_params)
   @new_cd.user = current_user
   authorize @new_cd

     if @new_cd.save
       redirect_to cds_path
     else
       flash[:error] = "There was an error saving the New Cd. Please try again."
       render :new
     end
  end

 def edit
   session[:return_to] = request.referer
   if current_user
      @newcd = NewCd.find(current_user) 
   else
      redirect_to home
   end

 end


 def update
   @newcd = NewCd.find(current_user)       
   if @newcd.update_attributes(newcd_params)
     if session[:return_to] != "http://localhost:3000/"
        
        
        redirect_to session.delete(:return_to)
     else
        redirect_to cds_path
    end
   else
     flash[:error] = "Error saving cd. Please try again."
     render :edit
   end
 end

 private

   def newcd_params
    params.require(:new_cd).permit(:new_rate, :new_fee, :new_term, :new_bankname)
   end

 end
