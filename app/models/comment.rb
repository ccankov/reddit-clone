class Comment < ApplicationRecord
  validates :content, :author, :post, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :Post

  has_one :parent_comment,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  has_many :child_comments,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment

  has_many :votes, as: :voteable, dependent: :destroy

  def upvote(voter)
    Vote.create(
      value: 1,
      user_id: voter.id,
      voteable_type: :Comment,
      voteable_id: self.id
    )
  end

  def downvote(voter)
    Vote.create(
      value: -1,
      user_id: voter.id,
      voteable_type: :Comment,
      voteable_id: self.id
    )
  end

  def vote_sum
    sum = votes.select('SUM(value) as vote_sum').order('').first.vote_sum
    sum.nil? ? 0 : sum
  end
end
