class QuestionsController < ApplicationController
  # defining a method like 'before_action' will make it so rails executes that method before executing the action
  # you can give before_action :only and :except which are obvs what they do
  before_action :find_question, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_user_question, only: [:edit, :update, :destroy]

  # include QuestionsAnswersHelper
  # helper_method :user_like

  def new
    # Define a new question to properly generate a form
    @question = Question.new
  end

  def create
    question_params
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      flash[:notice] = "Question created"
      redirect_to @question
    else
      flash.now[:alert] = "Question didn't save"
      # This will render 'app/views/questions/new.html.erb' because the default
      # in this action is a create
      render :new
    end
  end

  # Recieve a request: GET /questions/56
  # params[:id] will be '56'
  def show
    @answer = Answer.new
    respond_to do |format|
      format.html { render }
      format.json { render json: @question.to_json }
      format.xml { render xml: @question.to_xml }
    end
  end

  def index
    @questions = Question.all
    respond_to do |format|
      format.html { render }
      format.json { render json: @questions.select(:id, :title, :view_count) }
    end
  end

  def edit
  end

  def update
    # You can pass a notice as a option on the redirect but not the render
    if @question.update question_params
      redirect_to @question, notice: "Question updated"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Question deleted"
  end

  private

  def authorize_question
    redirect_to root_path unless can? :crud, @question
  end

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit([:title, :body, :category_id, {tag_ids: []}])
  end

  # def user_like
  #   @user_like ||= @question.like_for(current_user)
  # end
  # helper_method :user_like
end
