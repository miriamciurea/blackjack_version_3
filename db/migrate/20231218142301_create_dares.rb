class CreateDares < ActiveRecord::Migration[7.1]
  def change
    create_table :dares do |t|
      t.references :member, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
