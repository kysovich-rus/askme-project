class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save && @user&.nickname
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Регистрация успешно завершена!'
    else
      flash.now[:alert] = 'Неверно заполнены поля формы'
      render :new
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params) && @user&.nickname
      redirect_to root_path, notice: 'Обновлены данные пользователя'
    else
      flash.now[:alert] = 'Ошибки при попытке сохранить пользовательские данные'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удален'
  end

  private

  def user_params
    params.require(:user).permit(
      :real_name, :nickname, :email, :password, :password_confirmation, :header_color
    )
  end
end
