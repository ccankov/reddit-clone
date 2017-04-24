class Post < ApplicationRecord
  validates :title, :author, presence: true
  validate :at_least_one_sub

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :PostSub,
    inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :Comment

  def comments_by_parent_id
    comments_hash = Hash.new { |hash, key| hash[key] = [] }
    comments.each do |comment|
      comments_hash[comment.parent_comment_id] << comment
    end
    comments_hash
  end

  def at_least_one_sub
    if subs.length < 1
      errors[:base] << "Post must have at least one sub"
    end
  end
end
