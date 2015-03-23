class AnswersController < ApplicationController

  before_action :load_question, only: [:new, :create, :update, :destroy]
  before_action :authenticate_user!


  def new
    @answer = Answer.new(:question => @question)
  end

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Your answer added'
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.user == current_user
      if @answer.destroy
        flash[:alert] = 'Comment deleted. RIP!'
      else
        flash[:alert] = 'Houston, we got a problem...'
      end
    else
      flash[:alert] = 'Not your answer, sorry!'
    end
    redirect_to question_path(@question.id)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

end
