class Sub < ApplicationRecord
  validates :title, :moderator, presence: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :PostSub

  has_many :posts,
    through: :post_subs,
    source: :post
end
