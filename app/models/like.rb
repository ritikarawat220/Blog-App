class Like < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id' # specify the custom foreign key name
  belongs_to :post
end
