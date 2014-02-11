class CreatePms < ActiveRecord::Migration
  def change
    create_table :pms do |t|
      t.integer :sender_id
      t.string :message
      t.string :recipient_email
      t.integer :recipient_id
      
      t.timestamps
    end
  end
end
