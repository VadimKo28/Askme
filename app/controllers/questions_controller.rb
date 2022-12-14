class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update destroy edit]
  before_action :set_question_for_current_user, only: %i[update destroy edit hide]

  def create
    @question = Question.new(question_params)

    @question.author = current_user

    @question.save

    redirect_to user_path(@question.user), notice: "Новый вопрос создан"
  end

  def update
    @question.update(question_params)

    redirect_to user_path(@question.user), notice: "Вопрос обновлён"
  end

  def edit
  end

  def hide
    @question.update!(hidden: true)

    redirect_to @question
  end

  def destroy
    @user = @question.user

    @question.destroy

    redirect_to user_path(@user), notice: "Вопрос удалён"
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.order(created_at: :desc).last(10)

    @users = User.order(created_at: :desc).last(10)
  end

  def new
    #if params[:user_id].present?
    # user = User.find(params[:user_id])
    #  redirect_to(user_nickname: user)
    #  return
    #end

    @user = User.find_by!(nickname: params[:user_nickname])
    @question = Question.new(user: @user)
  end

  private

  def question_params
    params.require(:question).permit(:body, :user_id)
  end

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
