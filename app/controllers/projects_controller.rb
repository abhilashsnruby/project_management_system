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
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :category_name)
  end
end
