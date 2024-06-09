class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit,:destroy]
  before_action :set_prototype, only: [:edit,:show,:destroy,:update]
  before_action :set_prototypes, only: [:edit,:destroy]
  def index
    @prototypes = Prototype.includes(:user).order("created_at DESC")
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
    redirect_to root_path @prototype
    else
    render :new
  end
end

def edit
  
end

def update
  if @prototype.update(prototype_params)
  redirect_to prototype_path
  else
  render :edit
end
end

def destroy
  @prototype.destroy
  redirect_to root_path
end

  private
  def prototype_params
    params.require(:prototype).permit(:name, :image, :text, :title, :catch_copy, :concept).merge(user_id: current_user.id)
end
def set_prototype
  @prototype = Prototype.find(params[:id])
end

def set_prototypes
  unless user_signed_in? && current_user.id == @prototype.user_id
    redirect_to action: :index
  end

end
end