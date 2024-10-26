class AddAvatarToProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :avatar_url, :string
  end
end
