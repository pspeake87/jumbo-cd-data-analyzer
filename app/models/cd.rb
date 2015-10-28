class Cd < ActiveRecord::Base
   
   def calculate_fees_paid(cd, newcd)
      ((cd.principal * (newcd.new_fee/100)) / 365) * (cd.old_cd_start_date(cd))
   end

   def calculate_net_rate(cd, newcd)
      cd.old_rate - newcd.new_fee
      
   end

   def calculate_analysis_date(cd)
      Date.today.to_s
       
   end

   def calculate_remaining_term(cd)
      cd.maturity_date.to_date - Date.today
   end

   def calculate_ewp(cd)
      @penalty = (cd.princ_old_rate(cd)) * cd.old_ewp
   end

   def calculate_fees_remaining(cd, newcd)
      ((cd.principal * (newcd.new_fee/100)) / 365) * self.calculate_remaining_term(cd)
   end

   def calculate_cd_remaining(cd)
      (cd.princ_old_rate(cd)) * self.calculate_remaining_term(cd)
   end

   def calculate_cd_net_remaining(cd)
      @old_cd_net = self.calculate_cd_remaining(cd) - self.calculate_ewp(cd)
   end

   def calculate_new_net_rate(cd)
       cd.new_rate - cd.new_fee
   end

   def calculate_new_analysis_date(days)
      Date.today + days
   end

   def calculate_actual_mat_date
      Date.today + 5.years
   end

   def calculate_new_broker_fees_paid(cd, newcd)
      ((cd.principal * (newcd.new_fee/100)) / 365) * self.new_total_days
   end

   def calculate_new_cd_additional_days(cd)
      cd.new_total_days - self.calculate_remaining_term(cd)
   end

   def calculate_new_cd_return(cd, newcd)
      @net_return = ((cd.principal * (newcd.new_rate/100)) / 365) * self.calculate_remaining_term(cd)     
   end

   def calculate_new_cd_net_remaining
      @new_cd_net = @net_return - @penalty
   end

   def calculate_remaining_term_net_gain
      @new_cd_net - @old_cd_net
   end
   
   public


   def princ_old_rate(cd)
      ((cd.principal * (cd.old_rate/100)) / 365)
   end

   def old_cd_start_date(cd)

       (cd.maturity_date.to_date - Date.today) + 180    
   end

   def new_total_days
       self.calculate_actual_mat_date - Date.today
   end



end
