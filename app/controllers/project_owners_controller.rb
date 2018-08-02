class ProjectOwnersController < ApplicationController
  before_action :set_project_owner, only: [:show, :edit, :update, :destroy]

  # GET /project_owners
  # GET /project_owners.json
  def index
    @project_owners = ProjectOwner.all
  end

  # GET /project_owners/1
  # GET /project_owners/1.json
  def show
  end

  # GET /project_owners/new
  def new
    @project_owner = ProjectOwner.new
  end

  # GET /project_owners/1/edit
  def edit
  end

  # POST /project_owners
  # POST /project_owners.json
  def create
    @project_owner = ProjectOwner.new(project_owner_params)

    respond_to do |format|
      if @project_owner.save
        format.html { redirect_to @project_owner, notice: 'Project owner was successfully created.' }
        format.json { render :show, status: :created, location: @project_owner }
      else
        format.html { render :new }
        format.json { render json: @project_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign_projects_to_project_owner
    @projects = Project.all
    if params[:project_owner].present? && params[:owner_projects].present?
      @project_owner_projects = ProjectOwner.save_project_owner_details(params)
    end
  end

  # PATCH/PUT /project_owners/1
  # PATCH/PUT /project_owners/1.json
  def update
    respond_to do |format|
      if @project_owner.update(project_owner_params)
        format.html { redirect_to @project_owner, notice: 'Project owner was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_owner }
      else
        format.html { render :edit }
        format.json { render json: @project_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_owners/1
  # DELETE /project_owners/1.json
  def destroy
    @project_owner.destroy
    respond_to do |format|
      format.html { redirect_to project_owners_url, notice: 'Project owner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_owner
      @project_owner = ProjectOwner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_owner_params
      params.require(:project_owner).permit(:project_owner_name, :qualification, :user_id)
    end
end
