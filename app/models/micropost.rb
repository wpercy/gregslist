class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :post_title, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "50x50>", :tiny => "70x70>" }, :default_url => "/images/:style/missing.png"

  def comments
    Comment.where("micropost_id = ?", id)
  end

  def self.from_favorites(user)
    Micropost.where("tag IN (?)", user.favorites)
  end

  def self.recents(user)
    Micropost.order(created_at: :desc).limit(20)
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['post_title LIKE (:search) OR content LIKE (:search)', search: "%#{search}%"])
    else
      find(:all)
    end
  end

end
