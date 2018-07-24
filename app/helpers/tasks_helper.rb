module TasksHelper

  def commented_hours_ago(comment)
    current_time = Time.now
    created_date = (comment.created_at.strftime('%d').to_i)
    created_hour = comment.created_date_record
    current_hour = current_time.strftime('%H').to_i
    @hours_ago = current_hour.to_i - created_hour.to_i
    if (created_hour.to_i == current_hour.to_i)
      @hour = "Just now created"
    elsif ((created_hour.to_i > 1) && (created_hour.to_i < 24))
      hours = Time.now.strftime('%H')
      minutes = Time.now.strftime('%M')
      @hour = (hours + " hour" + " and " + minutes + " minutes ago ")
    elsif (created_hour.to_i > 24)
      find_current_details(created_hour)
    end
  end

  def find_current_details(created_date)
    (Time.now.strftime('%d').to_i - created_date).to_s + " days ago"
  end

  def no_of_comments_with_comment_id(params)
    comment_id = params[:comment_id]
    task_id = params[:task_id]
    if comment_id.present?
      Task.find(Comment.find(comment_id).task_id).comments.count
    elsif task_id.present?
      Task.find(task_id).comments.count
    end
  end
end
