class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      # else
      #   format.html { render action: "edit" }
      #   format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end
end


