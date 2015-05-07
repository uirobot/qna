class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:id])
    if @attachment.attachable.user_id == current_user.id
      @attachment.destroy
      render "question_file_delete"
    end
  end
end
