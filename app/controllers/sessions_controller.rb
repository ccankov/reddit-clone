class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params)
    if user
      login(user)
      redirect_to subs_url
    else
      flash[:errors] = ['Invalid username or password']
      redirect_to new_session_url
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
