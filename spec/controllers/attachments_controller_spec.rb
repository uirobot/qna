require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:question) { create(:question) }
  let(:attachment) { create(:attachment) }

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
        expect(response).to redirect_to questions_path
      end
    end
    describe 'DELETE #destroy another user question' do
      log_in_user
      let(:user2) { create(:user) }
      before do
        question.user = user2
        question.attachments << attachment
      end
      it 'deletes question' do
        expect { delete :destroy, id: attachment }.to_not change(Attachment, :count)
      end
      it 'redirect to index view' do
        delete :destroy, id: question
          expect(response).to redirect_to questions_path
      end
    end
  end
end
