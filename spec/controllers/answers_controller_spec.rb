require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  describe 'GET #new' do
    log_in_user
    before { get :new, question_id: question }

    it 'assign new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    log_in_user
    context 'with correct attributes' do
      it 'save answer to database' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end
      it 'redirect to question page' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to(question_path(assigns(:question)))
      end
    end

    context 'with invalid attributes' do
      it 'does not save to database' do
        expect { post :create, question_id: question, answer: {body:nil} }.to_not change(Answer, :count)
      end
      it 'redirect to new action' do
        post :create, question_id: question, answer: {body:nil}
        expect(response).to render_template :new
      end
    end
  end

end
