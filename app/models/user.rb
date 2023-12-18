class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :nickname, length: { minimum: 3 }
  validates :nickname, uniqueness: true

  has_many :member
  has_many :groups, through: :members
  # A User has many created_groups representing the groups they have created.
  # The creator_id foreign key in the Group model is used to associate a group with its creator.

  has_many :created_groups, class_name: 'Group', foreign_key: 'user_id'
end
