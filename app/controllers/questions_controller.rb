class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update show destroy edit toggle]

  def create 
    @question = Question.create(question_params)
    @question.user = User.find(question_params[:user_id])
    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user), notice: 'Вопрос создан'
    else
      flash.now[:alert] = 'Не удалось создать новый вопрос'
      redirect_to new_question_path(user_id: @question.user.id), alert: 'Не удалось создать вопрос'
    end
  end

  def update
    @question.update(question_params)

    redirect_to user_path(@question.user), notice: 'Вопрос сохранен'
  end

  def destroy
    user = @question.user
    @question.destroy

    redirect_to user_path(user), notice: 'Вопрос удален'
  end

  def show
  end

  def index
    @users = User.order(created_at: :desc).last(10)
    @questions = Question.order(created_at: :desc).last(10)
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

  def question_params
    params.require(:question).permit(:body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
