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
       
       

       redirect_to cds_path
     else
       flash[:error] = "There was an error saving the New Cd. Please try again."
       render :new
     end
  end

  def edit
     session[:return_to] = request.referer
     @newcd = NewCd.last
  end
  

  def update
     @newcd = NewCd.last
    
     
     def update
       respond_to do |format|
        if  @newcd.update_attributes(newcd_params)
           format.html { redirect_to plots_path, notice: 'Plot was successfully updated.' }
           format.json { render: @newcd }
           format.js
        else
           format.html { render action: 'edit' }
           format.json { render json: @newcd.errors, status: :unprocessable_entity }
    end
  end
end
     #if @newcd.update_attributes(newcd_params)
       #flash[:notice] = "New Cd was updated."
       #redirect_to session.delete(:return_to)
     #else
      # flash[:error] = "Error saving cd. Please try again."
       #render :edit
     #end
   #end

  private

def newcd_params
  params.require(:new_cd).permit(:new_rate, :new_fee, :new_term)
end
end
