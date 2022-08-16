class SessionsController < ApplicationController
  def create
    user_params = params.require(:session)
    user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password])

    if user.present?
      session[:user_id] = user.id
      redirect_to root_path, notice: "Произведен вход... Добро пожаловать, @#{current_user.nickname}"
    else
      flash.now[:alert] = 'Неверные учетные данные'
      render :new
    end
  end

  def new
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'Вы вышли из учетной записи'
  end
end
