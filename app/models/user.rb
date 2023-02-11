class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts
  has_many :comments
  has_many :likes

  validates :Name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }
  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  ROLES = %i[admin default].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end
end
