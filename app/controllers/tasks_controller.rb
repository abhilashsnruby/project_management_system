class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def display_task_details
    @tasks = Task.all
  end

  def task_comment_page
    if params[:destroy_comment_id].present?
      @comment = Comment.find(params[:destroy_comment_id])
      task_id = @comment.task_id
      @comment.destroy
      @comment_destory_data = Comment.find_comments(task_id)
      success = true
    end

    if params[:comment_id].present?
      if params[:commit] == 'update'
        @comment = Comment.find(params[:comment_id])
        @comment.update_attributes!(comment_name: params[:comment_name],
                                   comment_text: params[:comment_text], 
                                   task_id: params[:task_id], created_date_record: Comment.retrive_present_time)
        @comment = Comment.find_comments(params[:task_id])
        success = true
      else
        @comment = Comment.find(params[:comment_id])
        success = true
      end
    end

    task_id = params[:task_id]
    comment_name = params['comment_name']
    description = params['comment_description']
    if task_id_condition(params)
      if !params[:comment_id].present?
        @comment = @comment_destory_data.present? ? @comment_destory_data : Comment.find_comments(task_id)
        success = true
      end
    elsif task_comment_condition(params)
      @comment = Comment.assign_comments_to_task(task_id, comment_name, description)
      success == true
    else
      @comment = @comment_destory_data.present? ? @comment_destory_data : Comment.find_comments(task_id)
    end

    if success == true
      render "task_comment_page", comment: @comment, notice: "comment was assigned successfully"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def task_comment_condition(params)
      (params[:task_id].present? &&
       params[:comment_name].present? &&
       params[:comment_description].present? &&
       params[:commit].present?)
    end

    def task_id_condition(params)
      !params[:commit].present?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:task_name, :project_id)
    end
end