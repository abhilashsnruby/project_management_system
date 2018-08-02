class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource except: [:populate_projects]

  def index
    @projects = Project.all
  end

  def new
    check_for_moderate_users
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: 'Project was successfully created'
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated'
    else
      render :edit
    end
  end

  def show

  end

  def edit

  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def view_user_project_details
    @users = User.all
  end

  def populate_projects
    if params["user_id"].present?
      user = User.find(params["user_id"])
      @user_projects = user.projects
      @user_error_messages = []
      @user_error_messages << 'User does not have any projects assigned' if @user_projects.empty?
    end
    respond_to do |format|
      format.js
    end
  end

  def show_projects_of_users
    @projects = Project.all
    current_user = params[:format]
    redirect_to projects_url, :project => @projects, alert: "project does not belong to #{current_user}"
  end

  def assign_projects_to_users
    @projects = Project.all
    if params["user_name"].present? && params["user_projects"].present?
      @user_projects = Project.assign_projects_to_users(params)
    end
  end

  def assign_tasks
    check_for_moderate_users
    @projects = Project.all
    @tasks = Task.all
    project = params[:project].present?
    @project = project ? Project.find(params[:project]) : ''
    Project.assign_tasks_to_project(params) if project
    if @project.present?
      render partial: 'task_details', project: @project, notice: "successfully tasks assigend to project"
    else
      render layout: nil
    end
  end

  def project_tasks
    @projects = Project.all
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :category_name, :priority)
  end
end