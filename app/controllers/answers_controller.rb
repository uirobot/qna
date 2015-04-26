class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:new, :create, :update, :destroy, :edit]
  before_action :load_answer, only: [:edit, :update, :destroy, :correct_answer]

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def edit
  end

  def update
    render :edit unless @answer.update(answer_params)
  end

  def destroy
    if @answer.user_id == current_user.id
      flash[:alert] = @answer.destroy ? 'Comment deleted. RIP!' : 'We got a problem'
    else
      flash[:alert] = 'Not your answer, sorry!'
    end
  end

  def correct_answer
    @question = @answer.question
    if @question.user_id == current_user.id
      @answer.best ? flash[:notice] = 'Good good good' : flash[:notice] = 'Problems'
    else
      flash[:notice] = 'Slow down, bro'
    end
    redirect_to @question
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end
end
