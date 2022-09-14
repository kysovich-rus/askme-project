class QuestionSave
  def self.call(question:, params:)
    new(question: question, params: params).call
  end

  def call
    assign_params
    create_hashtags
  end

  private

  attr_reader :question, :params

  def initialize(question:, params:)
    @question = question
    @params = params
  end

  def assign_params
    question.attributes = params
  end

  def create_hashtags
    question.transaction do
      question.save!

      question.hashtags =
        "#{question.body} #{question.answer}"
          .downcase
          .scan(Hashtag::REGEXP)
          .uniq
          .map { |ht| Hashtag.find_or_create_by(text: ht.delete('#')) }
    end
    rescue ActiveRecord::RecordInvalid
  end
end