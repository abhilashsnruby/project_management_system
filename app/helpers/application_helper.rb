module ApplicationHelper
  
  def error_message(msg)
    html = ""
    html << "<div class=' alert alert-danger' align='left'>\n"
    html << "<a href='#' class='close right' onClick=\"parentNode.remove()\">×</a>"
    html << "\t\t\t<li>#{msg}</li>"
    html << "\t</div>\n"
    html
  end
end
