class AddJanToStores < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :jan, :string
  end
end
