module TasksHelper

  def commented_hours_ago(comment)
    current_time = Time.now
    created_date = (comment.created_at.strftime('%d').to_i)
    created_hour = comment.created_date_record
    current_hour = current_time.strftime('%H').to_i
    hours_ago = current_hour - created_hour
    hour = (created_hour == current_hour) ? "Just now created" : hours_ago.to_s
    (created_hour < 24) ? hour : find_current_details(created_date)
  end

  def find_current_details(created_date)
    (Time.now.strftime('%d').to_i - created_date).to_s + " days ago"
  end
end
