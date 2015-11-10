class WelcomeController < ApplicationController
  def index
    if current_user
    @newcd = NewCd.find(current_user)
    @transaction = Transaction.find(current_user)
    else
    @newcd = NewCd.new
    end

    

  end

end
