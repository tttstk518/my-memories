class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to my_page_path(user), notice: 'guestuserでログインしました。'
  end
end