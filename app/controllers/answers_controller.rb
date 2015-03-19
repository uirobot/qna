class AnswersController < ApplicationController

  def new
    @question = Question.find(params[:question_id])

    @answer = Answer.new(:question => @question)

  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    if @answer.save
      flash[:notice] = 'Your answer added'
      redirect_to @question
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

end
