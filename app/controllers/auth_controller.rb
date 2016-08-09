class AuthController < ApplicationController
  def login
    @title = I18n.t('log_in')
    if params[:then]
      @then = params[:then]
    end
  end

  def auth
    if User.where(:email => params[:user][:email]).exists?
      user = User.where(:email => params[:user][:email]).first
      if user.authenticate(params[:user][:password])
        if user.two_factor_count > 0 && !params[:user][:two_factor]
          @email = params[:user][:email]
          @password = params[:user][:password]
          render "auth/twofactor"
        elsif user.two_factor_count > 0 && params[:user][:two_factor]
          if user.validate_two_factor_code(params[:user][:two_factor])
            session[:current_user_id] = user.id
            if params[:user][:then]
              redirect_to params[:user][:then]
            else
              redirect_to root_path
            end
          else
            flash[:error] = "Could not validate two-factor code."
            redirect_to auth_path
          end
        else
          session[:current_user_id] = user.id
          if params[:user][:then]
            redirect_to params[:user][:then]
          else
            redirect_to root_path
          end
        end
      else
        flash[:error] = "Invalid email or password."
        redirect_to auth_path
      end
    else
      flash[:error] = "Invalid email or password."
      redirect_to auth_path
    end
  end

  def newuser
    user = User.create(:email => params[:user][:email], :password => params[:user][:password], :name => params[:user][:name])
    if user
      session[:current_user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Couldn't create user, you probably missed a field or two."
      redirect_to signup_path
    end
  end

  def logout
    session[:current_user_id] = nil
    redirect_to root_path
  end
end
