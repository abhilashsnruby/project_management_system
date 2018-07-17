module TasksHelper

  def commented_hours_ago(comment)
    current_time = Time.now
    created_date = (comment.created_at.strftime('%d').to_i)
    created_hour = (comment.created_at.strftime('%H').to_i)
    current_hour = current_time.strftime('%H').to_i
    hours_ago = current_hour - created_hour
    (created_hour < 24) ? (hours_ago.to_s + " hours ago") : find_current_details(created_date)
  end

  def find_current_details(created_date)
    (Time.now.strftime('%d').to_i - created_date).to_s + " days ago"
  end
end
