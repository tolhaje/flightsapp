class UsersController < ApplicationController
  expose(:user)

  def create
    if user.save
      redirect_to root_path, notice: "success"
    else
      render 'new'
    end
  end

  def update
    if user.save
      redirect_to account_path, notice: 'Account successfully updated'
    else
        flash.now[:error] = 'error'
      render 'edit'
    end
  end

  def activate
    if user = User.load_from_activation_token(params[:id])
      user.activate!
      redirect_to(login_path, notice: 'User was successfully activated.')
    else
      not_authenticated
    end
  end

  def claim_password
    if request.post?
      if user = User.where(email: params[:email]).first
        user.deliver_reset_password_instructions!
        redirect_to(login_path, notice: 'Password instructions were sent to your email.')
      else
        flash.now[:error] = 'Email not found.'
        render 'reset'
      end
    end
  end

  def reset_password
    user = User.load_from_reset_password_token params[:id]
    if request.post?
      if pass_params[:password] == pass_params[:password_confirmation]
        user.change_password! pass_params[:password]
        redirect_to(login_path, notice: 'Password successfully changed.')
      else
        flash.now[:error] = 'Passwords do not match'
        render 'reset_password'
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
