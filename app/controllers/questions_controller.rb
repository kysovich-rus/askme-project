class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update show destroy edit toggle]
  helper_method :author_link

  def create 
    @question = Question.create(question_params)

    if @question.save
      redirect_to question_path(@question), notice: 'Вопрос создан'
    else
      flash.now[:alert] = 'Не удалось создать новый вопрос'
      render :new
    end

  end

  def update
    @question.update(question_params)

    redirect_to question_path(@question)
  end

  def destroy
    @question.destroy

    redirect_to questions_path
  end

  def show
  end

  def index
    @users = User.order(created_at: :desc).last(10)
    @question = Question.new
    @questions = Question.order(created_at: :desc).last(10)
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def toggle
    @question.toggle!(:hidden)
    redirect_back fallback_location: root_path
  end

  def hidden?
    @question.hidden
  end

  private

  def author_link
    if author.present?
      link_to "#{question&.author&.link_name}", '#'
    else
      content_tag :i, "Aнонимус"
    end
  end

  def question_params
    params.require(:question).permit(:body, :user_id, :author_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
