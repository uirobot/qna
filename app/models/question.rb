class Question < ActiveRecord::Base
  validates :title, :body, presence: true
<<<<<<< HEAD
=======
  has_many :answers, dependent: :destroy
>>>>>>> lesson-3-basic-tdd
end
