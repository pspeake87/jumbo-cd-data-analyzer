class WelcomeController < ApplicationController
  helper_method :current_or_guest_user

  def index

    if current_user
    @newcd = NewCd.find(current_user)
    @transaction = Transaction.find(current_user)
    else
      @newcd = NewCd.find(session[:guest_user_id])
      @transaction = Transaction.find(session[:guest_user_id])
    
    
    end

    

  end

end
