class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answers = @question.answers.best_first
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.create(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = 'Your question created'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    unless @question.update(question_params)
      flash[:notice] = 'Take it easy, we got a problem'
    end
  end

  def destroy
    if @question.user_id == current_user.id
      @question.destroy
      flash[:notice] = 'Question deleted. RIP!'
    else
      flash[:notice] = 'Sorry, not your question'
    end
    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
