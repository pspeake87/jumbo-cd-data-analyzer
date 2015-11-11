class RegistrationsController < Devise::RegistrationsController
  before_filter :no_allow_register_unless_admin, only: [:new]
  skip_before_filter :require_no_authentication, only: [:new, :create]

  def new
    super
  end

  private

  def no_allow_register_unless_admin
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end

end