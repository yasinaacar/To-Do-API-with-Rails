class TaskCategory < ApplicationRecord
  has_many :tasks
  def total_tasks
    tasks.count
  end
end
