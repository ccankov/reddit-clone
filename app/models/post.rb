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

  has_many :votes, as: :voteable, dependent: :destroy

  def comments_by_parent_id
    comments_hash = Hash.new { |hash, key| hash[key] = [] }
    ordered_comments =
      comments.left_outer_joins(:votes).joins(:author)
              .group('comments.id, users.username')
              .order('SUM(votes.value) DESC')
              .select('comments.*, SUM(votes.value) as num_votes, users.username as author_name')
    ordered_comments.each do |comment|
      comments_hash[comment.parent_comment_id] << comment
    end
    comments_hash
  end

  def at_least_one_sub
    if subs.length < 1
      errors[:base] << "Post must have at least one sub"
    end
  end

  def upvote(voter)
    Vote.create(
      value: 1,
      user_id: voter.id,
      voteable_type: :Post,
      voteable_id: self.id
    )
  end

  def downvote(voter)
    Vote.create(
      value: -1,
      user_id: voter.id,
      voteable_type: :Post,
      voteable_id: self.id
    )
  end

  def vote_sum
    sum = votes.select('SUM(value) as vote_sum').order('').first.vote_sum
    sum.nil? ? 0 : sum
  end
end
