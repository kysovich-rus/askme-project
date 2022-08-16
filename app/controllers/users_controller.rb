class UsersController < ApplicationController
  def create
    user_params = params.require(:user).permit(:real_name, :nickname, :email)
    @user = User.create(user_params)

    redirect_to root_path, notice: 'Регистрация успешно завершена!'
  end

  def new
    @user = User.new
  end
end
