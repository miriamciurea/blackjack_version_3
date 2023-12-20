class Group < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :user, foreign_key: 'user_id'
  has_many :members
  validates :name, presence: true
end
