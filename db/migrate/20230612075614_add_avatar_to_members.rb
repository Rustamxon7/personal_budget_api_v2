class AddAvatarToMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :image, :string
    add_column :members, :kind, :string, default: "member"
  end
end
