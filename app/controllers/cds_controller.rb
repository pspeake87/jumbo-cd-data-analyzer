class CdsController < ApplicationController
  def index
    @cds = Cd.search(params[:search])
    newcd = NewCd.find(current_user)
    @cdss = []
    @cds.map do |cd|
      cd.new_cd = newcd
      @cdss << {
        cd: cd,
        net_gain: cd.calculate_remaining_term_net_gain
      } 
    end
    @cdss = @cdss.sort_by{|cd| cd[:net_gain]}.reverse.paginate(:per_page => 20, :page => params[:page])
  end

  def show
    @newcd = NewCd.find(current_user)
    @cd = Cd.find(params[:id])
    @cd.new_cd = @newcd

    @fees_paid = @cd.calculate_fees_paid(@cd)
    @net_rate = @cd.calculate_net_rate(@cd)
    @analysis_date = @cd.calculate_analysis_date(@cd)
    @remaining_term = @cd.calculate_remaining_term(@cd)
    @ewp_calc = @cd.calculate_ewp(@cd)
    @fees_remaining = @cd.calculate_fees_remaining(@cd)
    @old_cd_remaining = @cd.calculate_cd_remaining(@cd)
    @old_cd_net_remaining = @cd.calculate_cd_net_remaining(@cd)
    @old_net_gain_per_day = @cd.calculate_old_net_gain_per_day(@cd)
    @new_net_gain_per_day = @cd.calculate_new_net_gain_per_day(@cd)

    @new_net_rate = @cd.calculate_new_net_rate(@cd)
    @new_analysis_date = @cd.calculate_new_analysis_date(@remaining_term)
    @actual_mat_date = @cd.calculate_actual_mat_date
    @new_broker_fees_paid = @cd.calculate_new_broker_fees_paid(@cd)
    @new_cd_additional_days = @cd.calculate_new_cd_additional_days(@cd)
    @new_cd_return = @cd.calculate_new_cd_return(@cd)
    @new_cd_net_remaining = @cd.calculate_new_cd_net_remaining(@cd)
    @remaining_term_net_gain = @cd.calculate_remaining_term_net_gain
  end

  def edit
     @cd = Cd.find(params[:id])
     
  end
  

  def update
     @cd = Cd.find(params[:id])

     
     if @cd.update_attributes(params.require(:cd).permit(:old_rate, :principal, :maturity_date, :old_ewp, :old_fee))
        redirect_to @cd
     else
       flash[:error] = "Error saving cd. Please try again."
       render :edit
     end
   end

end
