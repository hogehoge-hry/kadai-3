class Book < ApplicationRecord
  belongs_to :user

  #タイトルと本文をバリデーション
  validates :title, presence: true
  validates :body, length: { maximum: 200 }
  validates :body, presence: true

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
