class AddBioToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :bio, :text
  end
end
