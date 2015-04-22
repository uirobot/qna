class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, :body, presence: true
  has_many :attachments, as: :attachable
end
