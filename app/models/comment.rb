class Comment < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at ASC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :micropost_id, presence: true
end
