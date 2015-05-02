require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let!(:question) { create(:question) }
  let(:attachment) { create(:attachment, attachable_type: "Question", attachable_id: question.id) }

  context 'attachment delete' do
    describe 'DELETE #destroy user question attachment' do
      log_in_user
      before do
        question.attachments << attachment
        @user.questions << question
      end
      it 'deletes question' do
        expect { delete :destroy, id: attachment }.to change(Attachment, :count).by(-1)
      end
      it 'redirect to question page' do
        delete :destroy, id: attachment
        expect(response).to redirect_to question_path(question)
      end
    end
    describe 'DELETE #destroy another user question attachment' do
      log_in_user
      let(:user2) { create(:user) }
      before do
        question.user = user2
        question.attachments << attachment
      end
      it 'trying to deletes question' do
        expect { delete :destroy, id: attachment }.to_not change(Attachment, :count)
      end
    end
  end
end
