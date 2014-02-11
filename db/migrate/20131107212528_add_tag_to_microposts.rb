class AddTagToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :tag, :string
    add_index :microposts, :tag
  end
end
