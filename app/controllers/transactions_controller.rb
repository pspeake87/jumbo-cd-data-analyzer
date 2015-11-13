class TransactionsController < ApplicationController
    def index
    @new_cds = NewCd.all
   end

   def show
    if current_user
      @newcd = NewCd.find(current_user)
      @cd = Transaction.find(current_user)
      @cd.new_cd = @newcd
    else
      # Guest user
      @newcd = NewCd.find(session[:guest_user_id])
      @cd = Transaction.find(session[:guest_user_id])
      @cd.new_cd = @newcd
    end
    
    @fees_paid = @cd.calculate_fees_paid(@cd)
    @net_rate = @cd.calculate_net_rate(@cd)
    @analysis_date = @cd.calculate_analysis_date(@cd)
    @remaining_term = @cd.calculate_remaining_term(@cd)
    @ewp_calc = @cd.calculate_ewp(@cd)
    @old_fees_remaining = @cd.calculate_old_fees_remaining(@cd)
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
    if current_user
    @transaction = Transaction.find(current_user)
    else
    @transaction = Transaction.find(session[:guest_user_id])
    end
  end

  def update
   if current_user  
      @transaction = Transaction.find(current_user)       
      if @transaction.update_attributes(transaction_params)
     
          redirect_to @transaction
      else
          flash[:error] = "Error saving topic. Please try again."
          render :edit
      end
   else 
       @transaction = Transaction.find(session[:guest_user_id]) 
       if @transaction.update_attributes(transaction_params)
     
          redirect_to @transaction
       else
          flash[:error] = "Error saving topic. Please try again."
          render :edit
       end
    end
   
   end

   private

   def transaction_params
    params.require(:transaction).permit(:principal, :old_rate, :old_fee, :old_term, :bankname, :start_date, :maturity_date, :old_penalty, :analysis_date)
   end
end