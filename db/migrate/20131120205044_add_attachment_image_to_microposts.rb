class AddAttachmentImageToMicroposts < ActiveRecord::Migration
  def self.up
    change_table :microposts do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :microposts, :image
  end
end
