class AnswersController < ApplicationController



  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question_id)
    else
      redirect_to question_path(@question)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

end
