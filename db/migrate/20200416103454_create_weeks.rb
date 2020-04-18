class CreateWeeks < ActiveRecord::Migration[5.2]
  def change
    create_table :weeks do |t|
      t.references :store, foreign_key: true
      t.string :week

      t.timestamps
    end
  end
end
