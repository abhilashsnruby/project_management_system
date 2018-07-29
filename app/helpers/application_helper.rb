module ApplicationHelper
  
  def error_message(msg)
    html = ""
    html << "<div class=' alert alert-danger' align='left'>\n"
    html << "<a href='#' class='close right' onClick=\"parentNode.remove()\">×</a>"
    html << "\t\t\t<li>#{msg}</li>"
    html << "\t</div>\n"
    html
  end

  def flash_class_name(name)
    case name
    when "notice" then "success"
    when "alert"  then "danger"
    else name
    end
  end

  def multi_authorize(value)
    name = [:read, :update, :create]
    case value
    when "read" then :read
    when "create" then :create
    when "update" then :update
    else name
    end
  end

  def check_for_super_user?
    super_user = ["superuser", "super_user"]
    if (User.count > 0)
      super_user_exists = User.where(user_name: super_user).present? ? true : false
    end
    super_user_exists
  end
end