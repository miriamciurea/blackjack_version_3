class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :member, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
