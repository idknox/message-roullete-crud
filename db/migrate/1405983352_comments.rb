class Comments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.string :body
      t.integer :msg_id
    end
  end

  def down
    drop_table :comments
  end
end
