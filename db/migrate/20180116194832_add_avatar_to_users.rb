class AddAvatarToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :avatar, :string
  end
end
