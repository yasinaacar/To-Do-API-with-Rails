class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.boolean :is_priority
      t.date :due_date
      t.timestamps
    end
  end
end
