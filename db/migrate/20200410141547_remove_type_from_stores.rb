class RemoveTypeFromStores < ActiveRecord::Migration[5.2]
  def change
    remove_column :stores, :type, :string
  end
end
