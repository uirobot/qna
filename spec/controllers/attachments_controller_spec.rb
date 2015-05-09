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
      it 'deletes attachments' do
        expect { delete :destroy, id: attachment, format: :js }.to change(Attachment, :count).by(-1)
      end
    end
    describe 'DELETE #destroy another user question attachment' do
      log_in_user
      let(:user2) { create(:user) }
      before do
        question.user = user2
        question.attachments << attachment
      end
      it 'trying to deletes attachments' do
        expect { delete :destroy, id: attachment, format: :js }.to_not change(Attachment, :count)
      end
    end
  end
end
