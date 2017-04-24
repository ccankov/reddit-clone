class PostsController < ApplicationController
  before_action :logged_in?, except: [:show]
  def new
    @post = Post.new
    render :new
  end

  def create
    new_post_params = post_params.merge(user_id: current_user.id)
    post = Post.new(new_post_params)
    if post.save
      redirect_to post_url(post)
    else
      flash[:errors] = post.errors.full_messages
      redirect_to new_post_url
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    if @post
      render :edit
    else
      redirect_to new_post_url
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    unless @post.user_id == current_user.id
      return redirect_to subs_url
    end
    if @post && @post.update_attributes(post_params)
      redirect_to post_url(@post)
    elsif @post.nil?
      redirect_to new_post_url
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to edit_post_url(@post)
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post
      render :show
    else
      redirect_to subs_url
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy if @post && @post.user_id == current_user.id
    redirect_to subs_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
