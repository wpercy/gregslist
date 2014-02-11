object @user

attributes :id, :name, :email, :admin, :location, :favorites

child :microposts do
  attributes :id, :created_at, :post_title, :tag
end

child :comments do
  attributes :id, :content, :micropost
end
