module Api
  class TasksController < ApplicationController
    before_action :set_task, only: %i[ show change update destroy ]
    before_action :authorized, except: [:all]

    # GET /tasks
    # GET /tasks.json
    def index
      @tasks = Task.where(user_id: @current_user.id)
      render json: {tasks: @tasks}, status: :ok
    end

    #シンプルに全てのtasksをloginなしで確認する用
    # GET /tasks/all
    def all
      @tasks = Task.all
      render json: @tasks
    end

    # GET /tasks/1
    # GET /tasks/1.json
    def show
      render json:@task, status: :ok
    end

    # POST /tasks
    # POST /tasks.json
    def create
      @task = @current_user.tasks.new(task_params)
      #task チェック用のコード
      # if @task.valid?
      #   render json: @task, status: :ok
      # else
      #   render json: {event: @task, errors: @task.errors }, status: :bad_request
      # end

      if @task.save
        render json: @task, status: :created, location: api_task_url(@task)
      else
        render json: {errors:@task.errors }, status: :unprocessable_entity
      end
    end

    #taskのcompletedを変更
    # GET /tasks/change/1
    def change
      @task.completed = !@task.completed

      if @task.save
        render json:@task, status: :ok
      else
        render json:@task.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tasks/1
    # PATCH/PUT /tasks/1.json
    def update
      if@task.update(user_params)
        render :show, status: :ok, location: api_task_url(@task)
      else
        render json:@task.errors, status: :unprocessable_entity
      end
    end

    # DELETE /tasks/1
    # DELETE /tasks/1.json
    def destroy
     @task.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_task
        @task = Task.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def task_params
        params.require(:task).permit(:title, :memo, :year, :month, :date)
      end
  end
end
