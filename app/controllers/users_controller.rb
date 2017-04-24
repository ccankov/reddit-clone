class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      login(user)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_session_url
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      redirect_to new_session_url
    end
  end
end
