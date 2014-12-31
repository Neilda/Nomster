class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    t.text :message
    t.string :rating

    t.integer :user_id
    t.integer :place_id
    t.timestamps
    end

    add_index :comments, [:user_id, :place_id]
    add_index :comments, :place_id
    # The first index will make it so if we need to lookup a comment either: just by user_id, or by user_id AND place_id it will be fast.
  end
end
