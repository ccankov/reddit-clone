class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :value, null: false, default: 1
      t.integer :user_id, null: false
      t.references :voteable, polymorphic: true, index: true
      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, [:user_id, :voteable_id, :voteable_type], unique: true
  end
end
