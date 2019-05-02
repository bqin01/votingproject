class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :vote_id, null: false
      t.string :voted_for, null: false, default: ""
      t.timestamps null: false
    end
    create_table :candids do |t|
      t.integer :candid_id, null: false
      t.string :name, null: false
      t.integer :num_votes, default: 0
    end
  end
end
