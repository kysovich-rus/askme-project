class QuestionsController < ApplicationController
  before_action :set_question_for_current_user, only: %i[update destroy edit toggle]
  before_action :ensure_current_user, only: %i[update destroy edit toggle]

  def create
    question_params = params.require(:question).permit(:body, :user_id)

    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      redirect_to @question.user, notice: 'Вопрос создан'
    else
      flash.now[:alert] = 'Не удалось создать новый вопрос'
      redirect_to new_question_path(user_id: @question.user.id), alert: 'Не удалось создать вопрос'
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)
    @question.update(question_params)

    redirect_to @question.user, notice: 'Вопрос сохранен'
  end

  def destroy
    user = @question.user
    @question.destroy

    redirect_to user, notice: 'Вопрос удален'
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @users = User.order(created_at: :desc).last(10)
    @questions = (
      Question.where(hidden: false)
              .or(Question.where(user: current_user).where(hidden: true))
    ).order(created_at: :desc).last(10)
  end

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def toggle
    @question.toggle!(:hidden)
    redirect_back fallback_location: root_path, notice: "Видимость вопроса #{@question.id} изменена"
  end

  def hidden?
    @question.hidden
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
