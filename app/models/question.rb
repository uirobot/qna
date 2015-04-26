class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, :body, presence: true
  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments, :allow_destroy => true, :reject_if => :all_blank
end
