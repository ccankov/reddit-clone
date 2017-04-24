class SubsController < ApplicationController
  before_action :logged_in?, except: [:index, :show]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    new_sub_params = sub_params.merge(user_id: current_user.id)
    sub = Sub.new(new_sub_params)
    if sub.save
      redirect_to sub_url(sub)
    else
      flash[:errors] = sub.errors.full_messages
      redirect_to new_sub_url
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    if @sub && @sub.user_id == current_user.id
      render :edit
    else
      redirect_to new_sub_url
    end
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    unless @sub.user_id == current_user.id
      return redirect_to subs_url
    end
    if @sub && @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    elsif @sub.nil?
      redirect_to new_sub_url
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to edit_sub_url(@sub)
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    if @sub
      @posts = @sub.posts_by_vote
      render :show
    else
      redirect_to subs_url
    end
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])
    @sub.destroy if @sub && @sub.user_id == current_user.id
    redirect_to subs_url
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
