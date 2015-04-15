require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should validate_presence_of :body }

  describe '#best' do

    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }
    let!(:answer2) { create(:answer, question: question, user: user, correct: true) }

    it 'sets corrects flag to true' do
      answer.best
      expect(answer.reload).to be_correct
      expect(question.answers.where(correct: true).count).to eq 1
    end

    # Создть вопрос и ответы несколько!
    # Для одного из ответов установить флаг (утснеовить флаг вручную)
    # Вызвать у другого ответа мето бест и проверяем что этот объект стал лучшим, сделать запрос и count проверить, либо прове
  end
end
