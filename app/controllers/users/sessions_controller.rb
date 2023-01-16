class Users::SessionsController < Devise::SessionsController

  def after_sign_up_path_for(resource)
      my_page_path(current_user.id)
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to my_page_path(user), notice: 'guestuserでログインしました。'
  end
end