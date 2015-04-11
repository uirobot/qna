class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def best
    Answer.where(question_id: self.question_id).update_all(correct: false)
    self.update!(correct: true)
  end
end
