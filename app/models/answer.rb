class Answer < ActiveRecord::Base
  scope :best_first, -> { order(correct: :desc, created_at: :asc) }

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, allow_destroy: true, :reject_if => :all_blank

  def best
    Answer.where(question: question).update_all(correct: false)
    self.update!(correct: true)
  end
end
