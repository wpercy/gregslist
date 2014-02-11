class Pm < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :sender_id, presence: true
	validates :recipient_email, presence: true
	validates :message, presence: true, length: { maximum: 512 }
end
