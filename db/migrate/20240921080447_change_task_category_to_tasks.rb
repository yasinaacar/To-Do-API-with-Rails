class ChangeTaskCategoryToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :task_category, null: true, foreign_key: true
    change_column_null :tasks, :task_category_id, true
  end
end
