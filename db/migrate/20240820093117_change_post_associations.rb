class ChangePostAssociations < ActiveRecord::Migration[7.1]
  def change
    # Remove the foreign key and the user_id column
    remove_reference :posts, :user, foreign_key: true

    # Add the profile_id column with a foreign key constraint
    add_reference :posts, :profile, null: false, foreign_key: true
  end
end
