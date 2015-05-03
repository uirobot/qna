class AttachmentsController < ApplicationController

  def destroy
    attachment = Attachment.find(params[:id])
    @attachment_id = attachment.id
    if attachment.attachable_type == "Question"
      question = Question.find(attachment.attachable_id)
      if question.user_id == current_user.id
        attachment.destroy
      end
      render "question_file_delete"
    end

    if attachment.attachable_type == "Answer"
      answer = Answer.find(attachment.attachable_id)
      if answer.user_id == current_user.id
        attachment.destroy
        flash[:notice] = 'Attachment destroy'
      end
      render "question_file_delete"
    end
  end

end
