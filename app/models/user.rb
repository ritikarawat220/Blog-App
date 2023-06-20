class User < ApplicationRecord
  has_one_attached :photo
  has_many :likes, foreign_key: 'author_id'
end
