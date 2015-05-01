class AttachmentsController < ApplicationController

  def destroy
    attachment = Attachment.find(params[:id])

    if attachment.attachable_type == "Question"
      question = Question.find(attachment.attachable_id)
      if question.user_id == current_user.id
        attachment.destroy
        flash[:notice] = 'Attachment destroy'
      end
      redirect_to question_path(question)
    end

    if attachment.attachable_type == "Answer"
      answer = Answer.find(attachment.attachable_id)
      if answer.user_id == current_user.id
        attachment.destroy
        flash[:notice] = 'Attachment destroy'
      end
      redirect_to question_path(answer.question)
    end
  end

end
