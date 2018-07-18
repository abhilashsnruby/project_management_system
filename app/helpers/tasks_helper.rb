module TasksHelper

  def commented_hours_ago(comment)
    current_time = Time.now
    created_date = (comment.created_at.strftime('%d').to_i)
    created_hour = comment.created_date_record
    current_hour = current_time.strftime('%H').to_i
    @hours_ago = current_hour - created_hour
    if (created_hour == current_hour)
      @hour = "Just now created"
    elsif ((created_hour > 1) && (created_hour < 24))
      hours = Time.now.strftime('%H')
      minutes = Time.now.strftime('%M')
      @hour = (hours + " hour" + " and " + minutes + " minutes ago ")
    elsif (created_hour > 24)
      find_current_details(created_hour)
    end
  end

  def find_current_details(created_date)
    (Time.now.strftime('%d').to_i - created_date).to_s + " days ago"
  end
end
