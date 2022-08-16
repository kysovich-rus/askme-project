class UsersController < ApplicationController
  def create
    user_params = params.require(:user).permit(:real_name, :nickname, :email, :password)
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Регистрация успешно завершена!'
    else
      flash.now[:alert] = 'Неверно заполнены поля формы'
      render :new
    end
  end

  def new
    @user = User.new
  end
end
