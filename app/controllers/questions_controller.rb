class QuestionsController < ApplicationController
  before_filter :find_question, :except => [:index, :new, :create]
  before_filter :find_asker, :except => [:index, :new, :create]
  before_filter :build_answer, :only => [:show]

  def index
    @questions = Question.all
  end

  def create
    puts params
    @question = Question.new(title: params[:question][:title], 
                             content: params[:question][:content], 
                             user_id: current_user.id)
    if @question.save 
      redirect_to user_path(current_user.id)
    else
      @errors = @question.errors.full_messages
      render :new
    end
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @question_votes = @question.sum_vote
    @errors = params[:errors] 
    @response_errors = params[:response_errors]
    @answers = @question.answers.select { |answer| answer.valid? }
  end

  def responses
    @question_response = @question.responses.new(user_id: current_user.id, content: params[:content]) #bugbug
    if @question_response.save
      redirect_to question_path(@question)
    else 
      @errors = @question_response.errors.full_messages  
      redirect_to question_path(@question, :response_errors => @errors)
    end
  end

  def upvote
    if current_user.upvote!(@question).valid?
      redirect_to question_path(@question)
    else
      flash[:notice] = 'You already voted!'
      redirect_to question_path(@question)
    end
  end

  def downvote
    if current_user.downvote!(@question).valid?
      redirect_to question_path(@question)
    else
      flash[:notice] = 'You already voted!'
      redirect_to question_path(@question)
    end
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def find_asker
    @question_asker = User.find(find_question.user_id)
  end

  def build_answer
    @answer = @question.answers.build
  end

end
