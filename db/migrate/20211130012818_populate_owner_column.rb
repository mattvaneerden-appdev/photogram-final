class PopulateOwnerColumn < ActiveRecord::Migration[6.0]
  def up
    remove_column :photos, :owner_id
    rename_column :photos, :user_id, :owner_id
  end

end
