module ApplicationHelper
  include FacebookShare

  def facebook_share_description_text
    if @post
      "#{@post.title} - #{@post.text}"
    elsif @user
      @user.blog_title
    else
      "Tagline"
    end
  end
end
