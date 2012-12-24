class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    user.save
    session[:user_id] = user.id

    if user.blog_title?
      # redirect_to "/#{user.slug}"
      redirect_to user_slug_path(user)
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end