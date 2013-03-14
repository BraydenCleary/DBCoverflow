class AnswersController < ApplicationController
  respond_to :js, :html
  def new

  end

  def index
  end

  def create
    @answer = Answer.new(user_id: current_user.id, content: params[:answer][:content], question_id: params[:answer][:question_id])
    @answer.save
    respond_with @answer
  end

  def show
  end

  def destroy
  end

  def edit
  end

  def update
  end

  def upvote
    @answer = Answer.find(params[:id])
    if current_user.upvote!(@answer).valid?
      redirect_to :back
    else
      flash[:notice] = 'You already voted!'
      redirect_to :back
    end
  end

  def downvote
    @answer = Answer.find(params[:id])
    if current_user.downvote!(@answer).valid?
      redirect_to :back
    else
      flash[:notice] = 'You already voted!'
      redirect_to :back
    end
  end

end
