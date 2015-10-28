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

  private

def newcd_params
  params.require(:new_cd).permit(:new_rate, :new_fee)
end
end
