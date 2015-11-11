class Transaction < ActiveRecord::Base
   belongs_to :user
   attr_accessor :new_cd   

   def calculate_fees_paid(cd)

      ((cd.principal * (cd.old_fee/100)) / 365) * (self.old_cd_start_date(cd))
   end

   def calculate_net_rate(cd)
      cd.old_rate - cd.old_fee
      
   end

   def calculate_analysis_date(cd)
      Date.today
       
   end

   def calculate_remaining_term(cd)
      cd.maturity_date.to_date - cd.analysis_date
   end

   def calculate_ewp(cd)
      cd.princ_old_rate(cd) * cd.old_penalty
   end

   def calculate_fees_remaining(cd)
      ((cd.principal * (new_cd.new_fee/100)) / 365) * self.calculate_remaining_term(cd)
   end

   def calculate_old_fees_remaining(cd)
      ((cd.principal * (cd.old_fee/100)) / 365) * self.calculate_remaining_term(cd)
   end

   def calculate_cd_remaining(cd)
      (cd.princ_old_rate(cd)) * self.calculate_remaining_term(cd)
   end

   def calculate_cd_net_remaining(cd)
      self.calculate_cd_remaining(cd) - self.calculate_old_fees_remaining(cd)
   end

   def calculate_new_net_rate(cd)
       new_cd.new_rate - new_cd.new_fee
   end

   def calculate_new_analysis_date(days)
      Date.today + days
   end

   def calculate_actual_mat_date
      self.analysis_date + new_cd.new_term.years
   end

   def calculate_new_broker_fees_paid(cd)
      ((cd.principal * (new_cd.new_fee/100)) / 365) * self.new_total_days
   end

   def calculate_new_cd_additional_days(cd)
      cd.new_total_days - self.calculate_remaining_term(cd)
   end

   def calculate_new_cd_return(cd)
      (((cd.principal * (new_cd.new_rate/100)) / 365) * self.calculate_remaining_term(cd))  -  self.calculate_fees_remaining(cd)
   end

   def calculate_new_cd_net_remaining(cd)
      self.calculate_new_cd_return(cd) - self.calculate_ewp(cd)
   end

   def calculate_remaining_term_net_gain #(cd)
      
      self.calculate_new_cd_net_remaining(self) - calculate_cd_net_remaining(self)
   end

   def calculate_old_net_gain_per_day(cd)
      (cd.principal * ((cd.old_rate - cd.old_fee)/100)) / 365
   end

   def calculate_new_net_gain_per_day(cd)
      
      (cd.principal * ((new_cd.new_rate - new_cd.new_fee)/100)) / 365
   end

   def princ_old_rate(cd)
      ((cd.principal * (cd.old_rate/100)) / 365)
   end

   def old_cd_start_date(cd)
     
       cd.maturity_date - cd.start_date    
   end

   def new_total_days
       self.calculate_actual_mat_date - self.analysis_date
   end

   def self.search(search)
       if search
         where('bankname LIKE ?', "%#{search}%")
       else
         all
       end
   end

end
