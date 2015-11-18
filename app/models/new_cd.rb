class NewCd < ActiveRecord::Base
   belongs_to :user

   validates :new_rate, numericality: { less_than: 10 }, presence: true, :on => :update
   validates :new_fee, numericality: { less_than: 10 },presence: true, :on => :update
   
end
