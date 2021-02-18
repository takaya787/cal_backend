class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :memo
      t.boolean :completed,default:false, null:false
      t.integer :year
      t.integer :month
      t.integer :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
