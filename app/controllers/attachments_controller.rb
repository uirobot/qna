class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:id])
    if @attachment.attachable.user_id == current_user.id
      @attachment.destroy
      render "question_file_delete"
    else
      render "file_delete_permited"
    end
  end
end
