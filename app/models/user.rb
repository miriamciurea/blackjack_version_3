class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_default_score, on: :create

  def set_default_score
    self.score = 0
  end

  validates :nickname, presence: true
  validates :nickname, length: { minimum: 3 }
  validates :nickname, uniqueness: true

  has_many :members, dependent: :destroy
  has_many :groups, through: :members, dependent: :destroy
  # A User has many created_groups representing the groups they have created.
  # The creator_id foreign key in the Group model is used to associate a group with its creator.

  has_many :created_groups, class_name: 'Group', foreign_key: 'user_id'
end
