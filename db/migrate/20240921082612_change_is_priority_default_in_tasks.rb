class ChangeIsPriorityDefaultInTasks < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tasks, :is_priority, false
  end
end
