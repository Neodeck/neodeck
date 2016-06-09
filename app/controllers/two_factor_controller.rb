class TwoFactorController < ApplicationController
  before_filter :validate_logged_in

  def index
    @title = "2-Factor Authentication"
  end

  def new
    if current_user.two_factor_count == 0
      @method = TwoFactorMethod.create(:user => current_user)
    else
      @method = current_user.two_factor_methods[0]
    end
  end

  def remove
    unless current_user.two_factor_count == 0
      current_user.two_factor_methods.destroy_all
      flash[:message] = "Two-factor authentication removed."
    end
    redirect_to twofac_path
  end

  def verify
    method = TwoFactorMethod.find(params[:verify][:method_id])
    if method.verify(params[:verify][:code])
      method.update(:verified => true)
      flash[:message] = "Two-factor method added!"
      redirect_to twofac_path
    else
      flash[:error] = "Unable to verify two-factor method."
      redirect_to twofac_new_path
    end
  end
end
