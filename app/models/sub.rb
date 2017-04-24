class Sub < ApplicationRecord
  validates :title, :moderator, presence: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :PostSub,
    inverse_of: :sub

  has_many :posts,
    through: :post_subs,
    source: :post

  def posts_by_vote
    posts.left_outer_joins(:votes).joins(:author)
         .group('posts.id, users.username')
         .order('SUM(votes.value) DESC')
         .select('posts.*, SUM(votes.value) as num_votes')
  end
end
