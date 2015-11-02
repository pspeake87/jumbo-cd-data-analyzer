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
     
   
     
     if @new_cd.save
       
       flash[:notice] = "Post was saved."

       redirect_to cds_path
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :new
     end
  end

  def edit
     session[:return_to] = request.referer
     @newcd = NewCd.last
  end
  

  def update
     @newcd = NewCd.last
    
     
     
     if @newcd.update_attributes(newcd_params)
       flash[:notice] = "Post was saved."
       redirect_to session.delete(:return_to)
     else
       flash[:error] = "Error saving cd. Please try again."
       render :edit
     end
   end

  private

def newcd_params
  params.require(:new_cd).permit(:new_rate, :new_fee, :new_term)
end
end
