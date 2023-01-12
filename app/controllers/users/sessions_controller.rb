class Users::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
      users_top_path(current_user.id)
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to users_top_path(user), notice: 'guestuserでログインしました。'
  end
end