class PostsController < ApplicationController
  before_filter :ensure_user_is_logged_in, except: [:show, :index]
  before_filter :no_root_path_logged_in, only: [:index]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
      format.atom
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # @post = Post.find(params[:id])
    user = User.find(params[:user_id])
    @post = Post.find(params[:post_id], :conditions => { :user_id => user })

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    unless current_user.slug == params[:user_id]
      return redirect_to user_slug_path(current_user), notice: "I don't think so"
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    user = User.find(params[:user_id])
    @post = Post.find(params[:post_id], :conditions => { :user_id => user })

    unless current_user == @post.user
      return redirect_to user_slug_path(current_user), notice: "I don't think so"
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_slug_path(current_user), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    user = User.find(params[:user_id])
    @post = Post.find(params[:post_id], :conditions => { :user_id => user })

    unless current_user == @post.user
      return redirect_to root_path, notice: "I don't think so"
    end

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to user_slug_path(current_user), notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    user = User.find(params[:user_id])
    @post = Post.find(params[:post_id], :conditions => { :user_id => user })

    unless current_user == @post.user
      return redirect_to user_slug_path(current_user) , notice: "I don't think so"
    end

    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_slug_path(current_user), notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def ensure_user_is_logged_in
    redirect_to root_path, :notice => "You must be logged in" unless current_user
  end

  def no_root_path_logged_in
    if current_user
      redirect_to user_slug_path(current_user)
    end
  end
end
