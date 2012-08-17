class Users::RegistrationsController < Devise::RegistrationsController

private
  def resource_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password, 
      :password_confirmation, :remember_me
    )
  end
end
