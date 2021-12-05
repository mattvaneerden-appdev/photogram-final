class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :photos, :image, :picture
  end
end
