class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :type
      t.integer :price
      t.string :maker

      t.timestamps
    end
  end
end
