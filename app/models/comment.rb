class Comment < ApplicationRecord
  belongs_to :task

  def self.assign_comments_to_task(task_id, comment_name, description)
    Comment.create!(comment_name: comment_name, comment_text: description, task_id: task_id)
    find_comment(task_id)
  end

  def self.find_comment(task_id)
    Comment.where(task_id: task_id)
  end
end
