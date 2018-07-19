class Comment < ApplicationRecord
  belongs_to :task
  mount_uploader :picture, PictureUploader
  has_many :documents
  attr_accessor :document_data

  def self.assign_comments_to_task(task_id, comment_name, description, item)
    comment = Comment.last
    if comment.present? && (comment.comment_name == comment_name)
      find_comments(task_id)
    else
      comment_data = Comment.create!(comment_name: comment_name, comment_text: description, task_id: task_id, created_date_record: retrive_present_time)
      parmas[:item][:document].each do |file|
        Document.create!(comment_id: comment_data.id, document: file)
      end
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