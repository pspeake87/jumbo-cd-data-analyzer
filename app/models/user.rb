class User < ActiveRecord::Base
  has_one :new_cds
  has_one :transactions
  
  # Only time a NewCd and Transaction is created
  after_create :build_newcd, :build_transaction 
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  def build_newcd
      NewCd.create(user: self)

  end

  def build_transaction
      Transaction.create(user: self, maturity_date:  Time.now.strftime('%Y-%m-%d'), start_date:  Time.now.strftime('%Y-%m-%d'))
  end

  def admin?
   role == 'admin'
  end

   def self.search(search)
       if search
         where('name LIKE ?', "%#{search}%")
       else
         all
       end
   end

  
end
