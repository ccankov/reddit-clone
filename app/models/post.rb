class Post < ApplicationRecord
  validates :title, :author, :sub, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :sub,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :Sub
end
