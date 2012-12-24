class Post < ActiveRecord::Base
  attr_accessible :text, :title
  belongs_to :user
  has_many :comments

  extend FriendlyId
  friendly_id :title, use: :slugged
end
