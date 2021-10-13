class Book < ApplicationRecord
  belongs_to :user

  #タイトルと本文をバリデーション
  validates :title, presence: true
  validates :body, length: { maximum: 200 }
  validates :body, presence: true
end
