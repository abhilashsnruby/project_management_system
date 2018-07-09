class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @projects = Project.all
  end

  def new
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

  def assign_tasks
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