class CdsController < ApplicationController
  def index
    @cds = Cd.all
    
  end

  def show
    @newcd = NewCd.find(1)
    @cd = Cd.find(params[:id])
    @fees_paid = @cd.calculate_fees_paid(@cd, @newcd)
    @net_rate = @cd.calculate_net_rate(@cd, @newcd)
    @analysis_date = @cd.calculate_analysis_date(@cd)
    @remaining_term = @cd.calculate_remaining_term(@cd)
    @ewp_calc = @cd.calculate_ewp(@cd)
    @fees_remaining = @cd.calculate_fees_remaining(@cd, @newcd)
    @old_cd_remaining = @cd.calculate_cd_remaining(@cd)
    @old_cd_net_remaining = @cd.calculate_cd_net_remaining(@cd)
    
    @new_net_rate = @cd.calculate_new_net_rate(@newcd)
    @new_analysis_date = @cd.calculate_new_analysis_date(@remaining_term)
    @actual_mat_date = @cd.calculate_actual_mat_date
    @new_broker_fees_paid = @cd.calculate_new_broker_fees_paid(@cd, @newcd)
    @new_cd_additional_days = @cd.calculate_new_cd_additional_days(@cd)
    @new_cd_return = @cd.calculate_new_cd_return(@cd, @newcd)
    @new_cd_net_remaining = @cd.calculate_new_cd_net_remaining
    @remaining_term_net_gain = @cd.calculate_remaining_term_net_gain
  end
end
