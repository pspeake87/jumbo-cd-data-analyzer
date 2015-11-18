require 'rails_helper'
 
 describe Cd do
   describe "CD methods" do
 
     before do
       @cd = Transaction.create(principal: 200000, old_rate: 1.5, old_fee: 0.1, start_date: "2014-01-01", maturity_date: "2018-01-01", old_penalty: 90, analysis_date: "2015-11-17")
       @newcd = NewCd.create(new_rate: 3.0, new_term: 5, new_fee: 0.1)
       @cd.new_cd = @newcd
     end
 
     describe '#Old Cd penalty amount' do
       it "calculates number of interest earned per day multiplied by the penaly days" do
         expect( @cd.calculate_ewp(@cd).round(2) ).to eq(739.73)
       end
     end
 
     describe '#Broker fees paid' do
       it "calculates the amount of fees paid per day multiplied by total days of old CD" do
         expect(@cd.calculate_fees_paid(@cd).round(2) ).to eq(800.55)
       end
     end
 
     describe '#remaining term' do
       it "returns the amount of days left on CD" do
         expect( @cd.calculate_remaining_term(@cd) ).to eq(776) 
       end
     end

     describe '#fees remaining' do
       it "calculates the fees paid per day multiplied by the remaining term" do
         expect( @cd.calculate_old_fees_remaining(@cd).round(2) ).to eq(425.21) 
       end
     end

     describe 'Old Cd Remaining' do
       it "returns the interest that will be earned the remainder of CD" do
         expect( @cd.calculate_cd_remaining(@cd).round(2) ).to eq(6378.08) 
       end
     end

     describe 'Net Old Cd Remaining' do
       it "returns the interest that will be earned the remainder of CD - fees" do
         expect( @cd.calculate_cd_net_remaining(@cd).round(2) ).to eq(5952.88) 
       end
     end

     describe 'New Broker Fees Paid' do
       it "returns the Broker Fees for the New CD" do
         expect( @cd.calculate_new_broker_fees_paid(@cd).round(2) ).to eq(1001.10) 
       end
     end

     describe 'New CD additional Days' do
       it "returns extra amount of days past the original cd maturity date" do
         expect( @cd.calculate_new_cd_additional_days(@cd) ).to eq(1051) 
       end
     end

     describe 'New CD Return' do
       it "returns the amount of money made during the analysis term - fees" do
         expect( @cd.calculate_new_cd_return(@cd).round(2) ).to eq(12330.96) 
       end
     end

     describe 'New CD net return' do
       it "returns the amount of money made during the analysis term - fees and penalty" do
         expect( @cd.calculate_new_cd_net_remaining(@cd).round(2) ).to eq(11591.23) 
       end
     end

     describe 'remaining term net gain' do
       it "returns the New CD return - the Old CD return" do
         expect( @cd.calculate_remaining_term_net_gain.round(2) ).to eq(5638.36) 
       end
     end
   end
 end