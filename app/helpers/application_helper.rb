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
end
