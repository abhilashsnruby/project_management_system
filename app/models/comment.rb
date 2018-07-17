class Comment < ApplicationRecord
  belongs_to :task

  def self.assign_comments_to_task(task_id, comment_name, description)
    comment = Comment.last
    if comment.present? && (comment.comment_name == comment_name)
      find_comments(task_id)
    else
      Comment.create!(comment_name: comment_name, comment_text: description, task_id: task_id, created_date_record: retrive_present_time)
    end
    find_comments(task_id)
  end

  def self.find_comments(task_id)
    comment = Comment.where(task_id: task_id)
  end

  def self.retrive_present_time
    Time.now.strftime('%H').to_i
  end
end