class ChangeFollowReferencesToProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_reference :follows, :follower, foreign_key: { to_table: :users }
    remove_reference :follows, :following, foreign_key: { to_table: :users }

    add_reference :follows, :follower, null: false, foreign_key: { to_table: :profiles }
    add_reference :follows, :following, null: false, foreign_key: { to_table: :profiles }
  end
end
