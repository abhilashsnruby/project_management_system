class RecordLogsController < ApplicationController
  def index
    @projects = current_user.projects
    @employee = current_user.employee
  end
end
