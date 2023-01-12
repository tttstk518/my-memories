class Admin::HomesController < ApplicationController
  def top
    @user = User.page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end
end
