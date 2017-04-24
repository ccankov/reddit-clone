class Vote < ApplicationRecord
  VALUES = [-1, 1]

  validates :voter, :value, :voteable_id, :voteable_type, presence: true
  validates_uniqueness_of :user_id, scope: [:voteable_id, :voteable_type]
  validates :value, inclusion: VALUES

  belongs_to :voter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :voteable, polymorphic: true
end
