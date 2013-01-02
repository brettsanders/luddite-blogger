# coding: utf-8

module ApplicationHelper
  include FacebookShare

  def facebook_share_description_text
    if @post
      truncate( remove_white_space("#{@post.title} - #{@post.text}"), :length => 320)
    elsif @user
      @user.blog_title
    else
      "Tagline"
    end
  end

  def remove_white_space(string)
    string.gsub("\n", " ").squeeze(" ").strip
  end
end
