class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :max_members

      t.timestamps
    end
  end
end
