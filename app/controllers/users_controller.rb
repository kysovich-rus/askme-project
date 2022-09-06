class UsersController < ApplicationController
  before_action :set_user, only: %i[update show edit update destroy]
  before_action :authorize_user, only: %i[edit delete]

  def create
    @user = User.create(user_params)
    if @user.save && @user&.nickname
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Регистрация успешно завершена!'
    else
      flash.now[:alert] = 'Неверно заполнены поля формы'
      render :new
    end
  end

  def index
    @question = Question.new
    @questions = Question.order(created_at: :desc).last(10)
    @users = User.order(created_at: :desc).last(10)
  end

  def new
    session[:current_time] = Time.now
    @user = User.new
  end

  def edit
  end

  def show

    if current_user.present? && current_user == @user
      @questions = Question.where(user: @user).order(created_at: :desc).last(10)
    else
      @questions = Question.where(user: @user).where(hidden: false).order(created_at: :desc).last(10)
    end
    @question = Question.new(user: @user)
  end

  def update
    if @user.update(user_params) && @user&.nickname
      redirect_to root_path, notice: 'Обновлены данные пользователя'
    else
      flash.now[:alert] = 'Ошибки при попытке сохранить пользовательские данные'
      render :edit
    end
  end

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удален'
  end

  private

  def authorize_user
    redirect_with_alert unless current_user == @user
  end

  def set_user
    @user = User.find_by(nickname: params[:nickname])
  end

  def user_params
    params.require(:user).permit(
      :real_name, :nickname, :email, :password, :password_confirmation, :header_color
    )
  end
end
