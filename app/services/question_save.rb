class QuestionSave
  def initialize(question:, params:)
    @question = question
    @params = params
  end

  def call
    question_save
  end

  private

  def question_save
    @question.transaction do
      @question.update!(@params)
      @question.hashtags =
        "#{@question.body} #{@question.answer}"
          .downcase
          .scan(Hashtag::REGEXP)
          .uniq
          .map { |ht| Hashtag.find_or_create_by(text: ht.delete('#')) }
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
