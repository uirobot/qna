class Answer < ActiveRecord::Base
  scope :best_first, -> { order(correct: :desc, created_at: :asc) }

  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def best
    Answer.where(question: question).update_all(correct: false)
    self.update!(correct: true)
  end
end
