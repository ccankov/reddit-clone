class Post < ApplicationRecord
  validates :title, :author, :sub

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :sub
end
