class QuestionSave
  def initialize(question:, params:)
    @question = question
    @params = params
  end

  def self.call(question:, params:)
    new(question: question, params: params).call
  end

  def call
    question_save
  end

  private

  attr_reader :question, :params

  def question_save
    @question.attributes = @params
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