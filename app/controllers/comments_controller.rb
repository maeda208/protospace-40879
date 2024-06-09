class CommentsController < ApplicationController

  def index
    @comment = Comment.new
    @prototype = Prototype.find(params[:prototype_id])
    @comments = @prototype.comments.includes(:user)
  end

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.new(comment_params)
    if @comment.save
      redirect_to prototype_comments_path(@prototype)
    else
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show"
    end
  end
  end
  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id,prototype_id: params[:prototype_id])
end
