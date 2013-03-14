class ResponsesController < ApplicationController

  def upvote
    @response = Response.find(params[:id])
    if current_user.upvote!(@response).valid?
      redirect_to :back
    else
      flash[:notice] = 'You already voted!'
      redirect_to :back
    end
  end

  def downvote
    @response = Response.find(params[:id])
    if current_user.downvote!(@response).valid?
      redirect_to :back
    else
      flash[:notice] = 'You already voted!'
      redirect_to :back
    end
  end
end
