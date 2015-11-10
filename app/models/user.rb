class User < ActiveRecord::Base
  has_one :new_cds
  has_one :transactions

  after_create :build_newcd, :build_transaction
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def build_newcd
      NewCd.create(user: self, new_fee: 1, new_rate: 1, new_term: 5, new_bankname: "new bankname")
  end

  def build_transaction
      Transaction.create(user: self)
  end

  def admin?
   role == 'admin'
  end

  
end
